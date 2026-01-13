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

  /// Applies one of two functions depending on the contained value.
  ///
  /// - [onLeft] is called if this is a [Left]
  /// - [onRight] is called if this is a [Right]
  T fold<T>(T Function(L left) onLeft, T Function(R right) onRight);

  /// Returns `true` if this instance represents a [Left] value.
  bool get isLeft => this is Left<L, R>;

  /// Returns `true` if this instance represents a [Right] value.
  bool get isRight => this is Right<L, R>;
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
  L? get leftOrNull {
    if (this is Left<L, R>) {
      return (this as Left<L, R>).value;
    }
    return null;
  }
}
