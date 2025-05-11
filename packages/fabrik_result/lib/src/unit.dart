/// Represents a return type with no meaningful value (like `void` but as a value).
///
/// Useful when you want to return something in a typed functional context
/// but don't care about the actual value.
final class Unit {
  const Unit();

  @override
  String toString() => 'unit';
}

/// Singleton instance of [Unit].
const unit = Unit();
