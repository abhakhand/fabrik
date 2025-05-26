/// Abstract base class for creating custom field validators.
abstract class FabrikValidator<T> {
  const FabrikValidator();

  /// Returns `null` if valid, or an error message if invalid.
  String? call(T value);
}
