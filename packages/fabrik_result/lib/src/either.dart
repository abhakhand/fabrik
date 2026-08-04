/// A type that represents one of two possible values:
/// a [Left] or a [Right].
///
/// [Either] is commonly used to model operations that can fail, where:
/// - [Left] represents a failure or error case
/// - [Right] represents a successful result
///
/// This makes failure handling explicit and avoids relying on exceptions
/// or nullable values.
///
/// Example:
/// ```dart
/// Either<Failure, User> result = await getUser();
///
/// result.fold(
///   (failure) => handleError(failure),
///   (user) => handleSuccess(user),
/// );
/// ```
///
/// Prefer [Either] when:
/// - an operation can fail for expected reasons
/// - the failure should be handled explicitly by the caller
sealed class Either<L, R> {
  const Either();

  /// Runs [body] and wraps the outcome in an [Either].
  ///
  /// Returns [Right] with the result if [body] completes normally, or [Left]
  /// with `onError(error, stackTrace)` if it throws. This is the standard way
  /// to bring exception-throwing code into an [Either] world.
  ///
  /// Example:
  /// ```dart
  /// final result = Either.tryCatch(
  ///   () => jsonDecode(raw) as Map<String, dynamic>,
  ///   (error, stackTrace) => ParseFailure('$error'),
  /// );
  /// ```
  static Either<L, R> tryCatch<L, R>(
    R Function() body,
    L Function(Object error, StackTrace stackTrace) onError,
  ) {
    try {
      return Right(body());
    } catch (error, stackTrace) {
      return Left(onError(error, stackTrace));
    }
  }

  /// Asynchronous counterpart to [tryCatch].
  ///
  /// Awaits [body] and returns [Right] with its result, or [Left] with
  /// `onError(error, stackTrace)` if it throws or its future rejects.
  ///
  /// Example:
  /// ```dart
  /// final result = await Either.tryCatchAsync(
  ///   () => api.fetchUser(id),
  ///   (error, stackTrace) => UserFailure('$error'),
  /// );
  /// ```
  static Future<Either<L, R>> tryCatchAsync<L, R>(
    Future<R> Function() body,
    L Function(Object error, StackTrace stackTrace) onError,
  ) async {
    try {
      return Right(await body());
    } catch (error, stackTrace) {
      return Left(onError(error, stackTrace));
    }
  }

  /// Applies one of two functions depending on the contained value.
  ///
  /// - [onLeft] is called if this is a [Left]
  /// - [onRight] is called if this is a [Right]
  T fold<T>(T Function(L left) onLeft, T Function(R right) onRight);

  /// Returns `true` if this instance represents a [Left] value.
  bool get isLeft => this is Left<L, R>;

  /// Returns `true` if this instance represents a [Right] value.
  bool get isRight => this is Right<L, R>;

  /// Transforms the success value, leaving a [Left] untouched.
  ///
  /// Example:
  /// ```dart
  /// final doubled = result.map((count) => count * 2);
  /// ```
  Either<L, T> map<T>(T Function(R right) transform) {
    return switch (this) {
      Left(value: final l) => Left<L, T>(l),
      Right(value: final r) => Right<L, T>(transform(r)),
    };
  }

  /// Transforms the failure value, leaving a [Right] untouched.
  ///
  /// Useful for converting a low-level error into a domain failure.
  ///
  /// Example:
  /// ```dart
  /// final mapped = result.mapLeft((e) => UserFailure(e.message));
  /// ```
  Either<T, R> mapLeft<T>(T Function(L left) transform) {
    return switch (this) {
      Left(value: final l) => Left<T, R>(transform(l)),
      Right(value: final r) => Right<T, R>(r),
    };
  }

  /// Chains another [Either]-returning operation onto a success value.
  ///
  /// If this is a [Left], [transform] is not called and the failure is
  /// propagated unchanged. This is how several fallible steps compose without
  /// nesting [fold] calls.
  ///
  /// Example:
  /// ```dart
  /// final result = findUser(id).flatMap((user) => loadProfile(user));
  /// ```
  Either<L, T> flatMap<T>(Either<L, T> Function(R right) transform) {
    return switch (this) {
      Left(value: final l) => Left<L, T>(l),
      Right(value: final r) => transform(r),
    };
  }

  /// Asynchronous counterpart to [flatMap].
  ///
  /// Example:
  /// ```dart
  /// final result = await findUser(id).flatMapAsync((u) => api.load(u));
  /// ```
  Future<Either<L, T>> flatMapAsync<T>(
    Future<Either<L, T>> Function(R right) transform,
  ) async {
    return switch (this) {
      Left(value: final l) => Left<L, T>(l),
      Right(value: final r) => await transform(r),
    };
  }

  /// Returns the success value, or the result of [orElse] if this is a [Left].
  ///
  /// Example:
  /// ```dart
  /// final count = result.getOrElse((failure) => 0);
  /// ```
  R getOrElse(R Function(L left) orElse) {
    return switch (this) {
      Left(value: final l) => orElse(l),
      Right(value: final r) => r,
    };
  }

  /// Swaps the sides of this [Either].
  ///
  /// A [Left] becomes a [Right] and vice versa. Occasionally useful when an
  /// API's success/failure convention is inverted from yours.
  Either<R, L> swap() {
    return switch (this) {
      Left(value: final l) => Right<R, L>(l),
      Right(value: final r) => Left<R, L>(r),
    };
  }
}

/// Represents the left side of [Either].
///
/// By convention, this is used to model a failure or error case.
final class Left<L, R> extends Either<L, R> {
  const Left(this.value);

  /// The contained failure value.
  final L value;

  @override
  T fold<T>(T Function(L left) onLeft, T Function(R right) onRight) {
    return onLeft(value);
  }

  @override
  bool operator ==(Object other) => other is Left<L, R> && other.value == value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Left($value)';
}

/// Represents the right side of [Either].
///
/// By convention, this is used to model a successful result.
final class Right<L, R> extends Either<L, R> {
  const Right(this.value);

  /// The contained success value.
  final R value;

  @override
  T fold<T>(T Function(L left) onLeft, T Function(R right) onRight) {
    return onRight(value);
  }

  @override
  bool operator ==(Object other) =>
      other is Right<L, R> && other.value == value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Right($value)';
}

/// Utility function to create a [Right] instance.
///
/// This is provided for readability and consistency at call sites.
///
/// Example:
/// ```dart
/// return right(user);
/// ```
Right<L, R> right<L, R>(R value) => Right(value);

/// Utility function to create a [Left] instance.
///
/// This is provided for readability and consistency at call sites.
///
/// Example:
/// ```dart
/// return left(Failure('Something went wrong'));
/// ```
Left<L, R> left<L, R>(L value) => Left(value);

/// Convenience extensions for working with [Either] values.
///
/// These helpers improve ergonomics in common imperative use cases
/// without introducing functional chaining or hidden control flow.
extension EitherExtensions<L, R> on Either<L, R> {
  /// Executes [action] if this is a [Right].
  ///
  /// Useful when you only care about the success case and want to
  /// perform a side effect.
  ///
  /// Example:
  /// ```dart
  /// result.onRight((value) {
  ///   print('Success: $value');
  /// });
  /// ```
  void onRight(void Function(R value) action) {
    if (this is Right<L, R>) {
      action((this as Right<L, R>).value);
    }
  }

  /// Executes [action] if this is a [Left].
  ///
  /// Useful for logging or handling failures without unwrapping
  /// the success case.
  ///
  /// Example:
  /// ```dart
  /// result.onLeft((error) {
  ///   logError(error);
  /// });
  /// ```
  void onLeft(void Function(L value) action) {
    if (this is Left<L, R>) {
      action((this as Left<L, R>).value);
    }
  }

  /// Returns the [Right] value or `null` if this is a [Left].
  ///
  /// This is useful when working with imperative code where `null`
  /// is an acceptable representation of absence.
  R? get rightOrNull {
    if (this is Right<L, R>) {
      return (this as Right<L, R>).value;
    }
    return null;
  }

  /// Returns the [Left] value or `null` if this is a [Right].
  ///
  /// Example:
  /// ```dart
  /// result.leftOrNull?.let((failure) => logError(failure));
  /// ```
  L? get leftOrNull {
    if (this is Left<L, R>) {
      return (this as Left<L, R>).value;
    }
    return null;
  }
}
