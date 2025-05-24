// ignore_for_file: avoid_classes_with_only_static_members

/// The default configuration for all [BaseFabrikModel] instances.
///
/// Currently, this config class only supports setting a default value for
/// [stringify].
///
/// See also:
/// * [BaseFabrikModel.stringify]
class BaseFabrikModelConfig {
  /// {@template stringify}
  /// Global [stringify] setting for all [BaseFabrikModel] instances.
  ///
  /// If [stringify] is overridden for a particular [BaseFabrikModel] instance,
  /// then the local [stringify] value takes precedence
  /// over [BaseFabrikModelConfig.stringify].
  ///
  /// This value defaults to true in debug mode and false in release mode.
  /// {@endtemplate}
  static bool get stringify {
    if (_stringify == null) {
      // ignore: prefer_asserts_with_message
      assert(() {
        _stringify = true;
        return true;
      }());
    }
    return _stringify ??= false;
  }

  /// {@macro stringify}
  static set stringify(bool value) => _stringify = value;

  static bool? _stringify;
}
