import 'dart:async';

/// Throttling status
enum ThrottleStatus {
  /// Ready to accept new events
  idle,

  /// Waiting for the end of the pause
  busy;

  const ThrottleStatus();

  /// Returns `true` if the throttle is currently idle
  bool get isIdle => this == ThrottleStatus.idle;

  /// Returns `true` if the throttle is currently busy
  bool get isBusy => this == ThrottleStatus.busy;

  @override
  String toString() => switch (this) {
    ThrottleStatus.idle => 'idle',
    ThrottleStatus.busy => 'busy',
  };
}

/// A type-safe, stream-backed throttler to limit the execution of a function
/// within a specified duration.
///
/// Emits `ThrottleStatus` updates on each invocation.
///
/// Example:
/// ```dart
/// final throttle = Throttle<void>(duration: Duration(seconds: 1));
///
/// throttle.throttle(() {
///   print('This will only run once per second max.');
/// });
///
/// throttle.listen((status) {
///   print('Status changed: $status');
/// });
/// ```
final class Throttle<T> extends Stream<ThrottleStatus>
    implements Sink<T Function()> {
  Throttle({Duration duration = const Duration(seconds: 1)})
    : assert(!duration.isNegative, 'Duration must be non-negative'),
      _duration = duration {
    _stateController.add(ThrottleStatus.idle);
  }

  Duration _duration;

  /// Gets the current throttle duration.
  Duration get duration => _duration;

  /// Updates the throttle duration.
  set duration(Duration value) {
    assert(!value.isNegative, 'Duration must be non-negative');
    _duration = value;
  }

  Timer? _timer;

  /// Whether the throttle is currently accepting events.
  bool get isIdle => _timer?.isActive != true;

  /// Whether the throttle is waiting before it can be called again.
  bool get isBusy => !isIdle;

  final StreamController<ThrottleStatus> _stateController =
      StreamController<ThrottleStatus>.broadcast(sync: true);

  /// Calls [func] if throttle is ready.
  ///
  /// Returns `null` if the throttle is busy.
  T? throttle(T Function() func) {
    if (_stateController.isClosed || isBusy) return null;

    _timer = Timer(_duration, () {
      _timer = null;
      if (!_stateController.isClosed) {
        _stateController.add(ThrottleStatus.idle);
      }
    });

    _stateController.add(ThrottleStatus.busy);

    try {
      return func();
    } on Object {
      rethrow;
    }
  }

  @override
  StreamSubscription<ThrottleStatus> listen(
    void Function(ThrottleStatus status)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) => _stateController.stream.listen(
    onData,
    onError: onError,
    onDone: onDone,
    cancelOnError: cancelOnError,
  );

  /// Shorthand for calling [throttle].
  @override
  T? add(T Function() data) => throttle(data);

  /// Disposes the throttle and closes the stream.
  @override
  void close() {
    _timer?.cancel();
    _timer = null;
    _stateController.close();
  }
}

/// Debounce status
enum DebounceStatus {
  /// Ready to queue a new action
  idle,

  /// Currently waiting for timeout
  waiting;

  const DebounceStatus();

  bool get isIdle => this == DebounceStatus.idle;
  bool get isWaiting => this == DebounceStatus.waiting;

  @override
  String toString() => switch (this) {
    DebounceStatus.idle => 'idle',
    DebounceStatus.waiting => 'waiting',
  };
}

/// Debounce utility that executes a function only after a pause
/// in rapid repeated calls.
///
/// Optionally accepts a [maxWait] duration to force execution after a maximum
/// wait time, regardless of how often debounce is called.
///
/// Example:
/// ```dart
/// final debouncer = Debounce<void>(duration: Duration(milliseconds: 300));
///
/// debouncer.debounce(() {
///   print('Called only after user stops typing for 300ms');
/// });
///
/// // Cancel a pending action without closing the stream:
/// debouncer.cancel();
/// ```
final class Debounce<T> extends Stream<DebounceStatus>
    implements Sink<T Function()> {
  Debounce({
    Duration duration = const Duration(milliseconds: 300),
    Duration? maxWait,
  }) : assert(!duration.isNegative, 'Duration must be non-negative'),
       assert(
         maxWait == null || !maxWait.isNegative,
         'maxWait must be non-negative',
       ),
       _duration = duration,
       _maxWait = maxWait {
    _stateController.add(DebounceStatus.idle);
  }

  final Duration _duration;
  final Duration? _maxWait;
  Timer? _timer;
  Timer? _maxWaitTimer;

  /// The latest function queued for deferred execution.
  T Function()? _pendingFunc;

  final StreamController<DebounceStatus> _stateController =
      StreamController<DebounceStatus>.broadcast(sync: true);

  DebounceStatus get status =>
      _timer?.isActive == true ? DebounceStatus.waiting : DebounceStatus.idle;

  bool get isWaiting => status == DebounceStatus.waiting;
  bool get isIdle => status == DebounceStatus.idle;

  void _flush() {
    final fn = _pendingFunc;
    _timer?.cancel();
    _maxWaitTimer?.cancel();
    _timer = null;
    _maxWaitTimer = null;
    _pendingFunc = null;
    if (!_stateController.isClosed) {
      _stateController.add(DebounceStatus.idle);
    }
    fn?.call();
  }

  /// Queues [func] to be called after [duration] of inactivity.
  ///
  /// Each call resets the debounce timer. If [maxWait] is set, the function
  /// will be called regardless once [maxWait] has elapsed since the first
  /// queued call in the current burst.
  ///
  /// Always returns `null` — debounced execution is deferred and the result
  /// cannot be returned synchronously.
  T? debounce(T Function() func) {
    if (_stateController.isClosed) return null;

    _pendingFunc = func;

    _timer?.cancel();
    _stateController.add(DebounceStatus.waiting);
    _timer = Timer(_duration, _flush);

    // Start the maxWait timer only once per burst (don't reset it on each call)
    if (_maxWait != null && _maxWaitTimer?.isActive != true) {
      _maxWaitTimer = Timer(_maxWait, _flush);
    }

    return null;
  }

  @override
  StreamSubscription<DebounceStatus> listen(
    void Function(DebounceStatus status)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) => _stateController.stream.listen(
    onData,
    onError: onError,
    onDone: onDone,
    cancelOnError: cancelOnError,
  );

  /// Shorthand for [debounce].
  @override
  T? add(T Function() data) => debounce(data);

  /// Cancels any pending execution and resets to idle.
  ///
  /// Unlike [close], the stream remains open and can accept new calls
  /// after cancellation.
  void cancel() {
    _timer?.cancel();
    _maxWaitTimer?.cancel();
    _timer = null;
    _maxWaitTimer = null;
    _pendingFunc = null;
    if (!_stateController.isClosed) {
      _stateController.add(DebounceStatus.idle);
    }
  }

  /// Cancels any pending execution and closes the stream.
  @override
  void close() {
    _timer?.cancel();
    _maxWaitTimer?.cancel();
    _timer = null;
    _maxWaitTimer = null;
    _pendingFunc = null;
    _stateController.close();
  }
}
