import 'package:fabrik_utils/fabrik_utils.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Throttle', () {
    test('executes function when idle', () {
      final throttle = Throttle<int>(duration: const Duration(seconds: 1));

      final result = throttle.throttle(() => 42);
      throttle.close();

      expect(result, 42);
    });

    test('returns null when busy', () {
      fakeAsync((async) {
        final throttle = Throttle<int>(
          duration: const Duration(milliseconds: 500),
        );

        throttle.throttle(() => 1); // first call — executes
        final result = throttle.throttle(() => 2); // busy — returns null
        async.elapse(const Duration(milliseconds: 500));
        throttle.close();

        expect(result, isNull);
      });
    });

    test('becomes idle after duration elapses', () {
      fakeAsync((async) {
        final throttle = Throttle<int>(
          duration: const Duration(milliseconds: 300),
        );

        throttle.throttle(() => 1);
        expect(throttle.isBusy, isTrue);

        async.elapse(const Duration(milliseconds: 300));
        expect(throttle.isIdle, isTrue);

        throttle.close();
      });
    });

    test('emits status stream events', () {
      fakeAsync((async) {
        final throttle = Throttle<void>(
          duration: const Duration(milliseconds: 200),
        );
        final statuses = <ThrottleStatus>[];
        throttle.listen(statuses.add);

        throttle.throttle(() {});
        async.elapse(const Duration(milliseconds: 200));
        throttle.close();

        expect(statuses, [
          ThrottleStatus.busy,
          ThrottleStatus.idle,
        ]);
      });
    });

    test('add() is shorthand for throttle()', () {
      final throttle = Throttle<String>(duration: const Duration(seconds: 1));

      final result = throttle.add(() => 'hello');
      throttle.close();

      expect(result, 'hello');
    });

    test('does not execute when closed', () {
      final throttle = Throttle<int>(duration: const Duration(seconds: 1));
      throttle.close();

      final result = throttle.throttle(() => 99);
      expect(result, isNull);
    });

    test('ThrottleStatus enum helpers', () {
      expect(ThrottleStatus.idle.isIdle, isTrue);
      expect(ThrottleStatus.idle.isBusy, isFalse);
      expect(ThrottleStatus.busy.isBusy, isTrue);
      expect(ThrottleStatus.busy.isIdle, isFalse);
    });
  });

  group('Debounce', () {
    test('does not execute immediately', () {
      fakeAsync((async) {
        final debounce = Debounce<void>(
          duration: const Duration(milliseconds: 300),
        );

        var called = false;
        debounce.debounce(() => called = true);

        expect(called, isFalse);
        async.elapse(const Duration(milliseconds: 300));
        expect(called, isTrue);

        debounce.close();
      });
    });

    test('executes only the last call in a rapid burst', () {
      fakeAsync((async) {
        final debounce = Debounce<int>(
          duration: const Duration(milliseconds: 300),
        );

        final calls = <int>[];
        debounce.debounce(() {
          calls.add(1);
          return 1;
        });
        async.elapse(const Duration(milliseconds: 100));
        debounce.debounce(() {
          calls.add(2);
          return 2;
        });
        async.elapse(const Duration(milliseconds: 100));
        debounce.debounce(() {
          calls.add(3);
          return 3;
        });
        async.elapse(const Duration(milliseconds: 300));
        debounce.close();

        expect(calls, [3]); // only the last one executes
      });
    });

    test('always returns null', () {
      fakeAsync((async) {
        final debounce = Debounce<int>(
          duration: const Duration(milliseconds: 300),
        );

        final result = debounce.debounce(() => 42);
        async.elapse(const Duration(milliseconds: 300));
        debounce.close();

        expect(result, isNull);
      });
    });

    test('emits waiting then idle status', () {
      fakeAsync((async) {
        final debounce = Debounce<void>(
          duration: const Duration(milliseconds: 200),
        );
        final statuses = <DebounceStatus>[];
        debounce.listen(statuses.add);

        debounce.debounce(() {});
        async.elapse(const Duration(milliseconds: 200));
        debounce.close();

        expect(statuses, [
          DebounceStatus.waiting,
          DebounceStatus.idle,
        ]);
      });
    });

    test('add() is shorthand for debounce()', () {
      fakeAsync((async) {
        final debounce = Debounce<void>(
          duration: const Duration(milliseconds: 100),
        );

        var called = false;
        debounce.add(() => called = true);
        async.elapse(const Duration(milliseconds: 100));
        debounce.close();

        expect(called, isTrue);
      });
    });

    test('cancel() stops pending execution', () {
      fakeAsync((async) {
        final debounce = Debounce<void>(
          duration: const Duration(milliseconds: 300),
        );

        var called = false;
        debounce.debounce(() => called = true);
        expect(debounce.isWaiting, isTrue);

        debounce.cancel();
        expect(debounce.isIdle, isTrue);

        async.elapse(const Duration(milliseconds: 300));
        debounce.close();

        expect(called, isFalse);
      });
    });

    test('cancel() allows new calls after cancellation', () {
      fakeAsync((async) {
        final debounce = Debounce<void>(
          duration: const Duration(milliseconds: 300),
        );

        debounce.debounce(() {});
        debounce.cancel();

        var called = false;
        debounce.debounce(() => called = true);
        async.elapse(const Duration(milliseconds: 300));
        debounce.close();

        expect(called, isTrue);
      });
    });

    test('does not execute when closed', () {
      fakeAsync((async) {
        final debounce = Debounce<void>(
          duration: const Duration(milliseconds: 100),
        );

        var called = false;
        debounce.close();
        debounce.debounce(() => called = true);

        async.elapse(const Duration(milliseconds: 100));

        expect(called, isFalse);
      });
    });

    group('maxWait', () {
      test('forces execution before debounce timeout', () {
        fakeAsync((async) {
          final debounce = Debounce<void>(
            duration: const Duration(milliseconds: 500),
            maxWait: const Duration(milliseconds: 200),
          );

          var callCount = 0;
          debounce.debounce(() => callCount++);
          async.elapse(const Duration(milliseconds: 100));
          debounce.debounce(() => callCount++);
          async.elapse(const Duration(milliseconds: 100));
          // 200ms elapsed — maxWait fires
          debounce.close();

          expect(callCount, 1);
        });
      });

      test('maxWait resets after execution', () {
        fakeAsync((async) {
          final debounce = Debounce<void>(
            duration: const Duration(milliseconds: 500),
            maxWait: const Duration(milliseconds: 200),
          );

          var callCount = 0;
          debounce.debounce(() => callCount++);
          async.elapse(const Duration(milliseconds: 200));
          expect(callCount, 1);

          // Start a new burst
          debounce.debounce(() => callCount++);
          async.elapse(const Duration(milliseconds: 200));
          debounce.close();

          expect(callCount, 2);
        });
      });
    });

    test('DebounceStatus enum helpers', () {
      expect(DebounceStatus.idle.isIdle, isTrue);
      expect(DebounceStatus.idle.isWaiting, isFalse);
      expect(DebounceStatus.waiting.isWaiting, isTrue);
      expect(DebounceStatus.waiting.isIdle, isFalse);
    });
  });
}
