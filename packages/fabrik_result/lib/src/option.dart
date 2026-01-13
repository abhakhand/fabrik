/// A type that represents an optional value.
///
/// An [Option] can either be:
/// - [Some], containing a value
/// - [None], representing the absence of a value
///
/// This type is an explicit alternative to nullable values and is useful
/// when the absence of a value is a valid and expected state.
///
/// Example:
/// ```dart
/// Option<User> user = findUser();
///
/// user.fold(
///   () => handleNotFound(),
///   (u) => handleUser(u),
/// );
/// ```
sealed class Option<T> {
  const Option();

  /// Applies one of two functions depending on whether a value is present.
  ///
  /// - [onNone] is called if this is [None]
  /// - [onSome] is called if this is [Some]
  R fold<R>(R Function() onNone, R Function(T value) onSome);

  /// Returns `true` if this is [Some].
  bool get isSome => this is Some<T>;

  /// Returns `true` if this is [None].
  bool get isNone => this is None<T>;
}

/// Represents the presence of a value.
final class Some<T> extends Option<T> {
  const Some(this.value);

  /// The contained value.
  final T value;

  @override
  R fold<R>(R Function() onNone, R Function(T value) onSome) {
    return onSome(value);
  }

  @override
  String toString() => 'Some($value)';
}

/// Represents the absence of a value.
final class None<T> extends Option<T> {
  const None();

  @override
  R fold<R>(R Function() onNone, R Function(T value) onSome) {
    return onNone();
  }

  @override
  String toString() => 'None';
}

/// Utility function to create a [Some] instance.
///
/// Example:
/// ```dart
/// return some(user);
/// ```
Some<T> some<T>(T value) => Some(value);

/// Utility function to create a [None] instance.
///
/// Example:
/// ```dart
/// return none<User>();
/// ```
None<T> none<T>() => None<T>();
