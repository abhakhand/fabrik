/// Represents a return type with no meaningful value.
///
/// [Unit] is similar to `void`, but can be used as a concrete value in
/// typed APIs such as [Either] or [Option].
///
/// This is useful when an operation succeeds but does not produce
/// any data that needs to be returned.
///
/// Example:
/// ```dart
/// Either<Failure, Unit> result = await saveUser(user);
/// return right(unit);
/// ```
final class Unit {
  const Unit();

  @override
  String toString() => 'unit';
}

/// A shared instance of [Unit].
///
/// Since [Unit] has no state, a single instance is sufficient.
const unit = Unit();
