/// A type that represents one of two possible values:
/// either a [Left] (usually used for failure) or a [Right] (usually success).
///
/// This is a common functional pattern for modeling operations that can fail.
///
/// Example:
/// ```dart
/// Either<Failure, User> result = await getUser();
/// result.fold(
///   (failure) => handleError(failure),
///   (user) => handleSuccess(user),
/// );
/// ```
sealed class Either<L, R> {
  const Either();

  /// Applies one of two functions to the value inside:
  /// - [onLeft] if this is a [Left]
  /// - [onRight] if this is a [Right]
  T fold<T>(T Function(L left) onLeft, T Function(R right) onRight);

  /// Returns `true` if this is a [Left].
  bool get isLeft => this is Left<L, R>;

  /// Returns `true` if this is a [Right].
  bool get isRight => this is Right<L, R>;
}

/// A wrapper class representing the left side of [Either], typically used for failure.
final class Left<L, R> extends Either<L, R> {
  const Left(this.value);

  /// The failure value.
  final L value;

  @override
  T fold<T>(T Function(L left) onLeft, T Function(R right) onRight) {
    return onLeft(value);
  }

  @override
  String toString() => 'Left($value)';
}

/// A wrapper class representing the right side of [Either], typically used for success.
final class Right<L, R> extends Either<L, R> {
  const Right(this.value);

  /// The success value.
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
/// Example:
/// ```dart
/// return right(user);
/// ```
Right<L, R> right<L, R>(R r) => Right(r);

/// Utility function to create a [Left] instance.
///
/// Example:
/// ```dart
/// return left(Failure('Something went wrong'));
/// ```
Left<L, R> left<L, R>(L l) => Left(l);
