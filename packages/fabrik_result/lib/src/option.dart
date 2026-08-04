import 'package:fabrik_result/src/either.dart';

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

  /// Creates an [Option] from a nullable value.
  ///
  /// Returns [None] if [value] is `null`, otherwise [Some]. This is the bridge
  /// between Dart's null-safety and [Option], and is especially handy when
  /// reading loosely typed data such as JSON.
  ///
  /// Example:
  /// ```dart
  /// final name = Option.fromNullable(json['name'] as String?);
  /// ```
  static Option<T> fromNullable<T extends Object>(T? value) {
    return value == null ? None<T>() : Some<T>(value);
  }

  /// Applies one of two functions depending on whether a value is present.
  ///
  /// - [onNone] is called if this is [None]
  /// - [onSome] is called if this is [Some]
  R fold<R>(R Function() onNone, R Function(T value) onSome);

  /// Returns `true` if this is [Some].
  bool get isSome => this is Some<T>;

  /// Returns `true` if this is [None].
  bool get isNone => this is None<T>;

  /// Returns the contained value, or `null` if this is [None].
  ///
  /// The inverse of [fromNullable]; use it to hand an [Option] back to APIs
  /// that expect a nullable value.
  T? toNullable() {
    return switch (this) {
      Some(value: final v) => v,
      None() => null,
    };
  }

  /// Transforms the contained value, leaving [None] untouched.
  ///
  /// Example:
  /// ```dart
  /// final length = name.map((n) => n.length);
  /// ```
  Option<R> map<R>(R Function(T value) transform) {
    return switch (this) {
      Some(value: final v) => Some<R>(transform(v)),
      None() => None<R>(),
    };
  }

  /// Chains another [Option]-returning operation onto a present value.
  ///
  /// Example:
  /// ```dart
  /// final city = user.flatMap((u) => u.address).map((a) => a.city);
  /// ```
  Option<R> flatMap<R>(Option<R> Function(T value) transform) {
    return switch (this) {
      Some(value: final v) => transform(v),
      None() => None<R>(),
    };
  }

  /// Returns the contained value, or the result of [orElse] if this is [None].
  ///
  /// Example:
  /// ```dart
  /// final displayName = name.getOrElse(() => 'Anonymous');
  /// ```
  T getOrElse(T Function() orElse) {
    return switch (this) {
      Some(value: final v) => v,
      None() => orElse(),
    };
  }

  /// Keeps the value only if it satisfies [predicate], otherwise returns
  /// [None].
  ///
  /// Example:
  /// ```dart
  /// final adult = age.where((a) => a >= 18);
  /// ```
  Option<T> where(bool Function(T value) predicate) {
    return switch (this) {
      Some(value: final v) => predicate(v) ? this : None<T>(),
      None() => this,
    };
  }

  /// Converts this [Option] into an [Either], using [onNone] to supply the
  /// failure when no value is present.
  ///
  /// Example:
  /// ```dart
  /// final result = user.toEither(() => UserFailure('not found'));
  /// ```
  Either<L, T> toEither<L>(L Function() onNone) {
    return switch (this) {
      Some(value: final v) => Right<L, T>(v),
      None() => Left<L, T>(onNone()),
    };
  }
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
  bool operator ==(Object other) => other is Some<T> && other.value == value;

  @override
  int get hashCode => value.hashCode;

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
  bool operator ==(Object other) => other is None;

  @override
  int get hashCode => (None).hashCode;

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
