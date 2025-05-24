import 'package:fabrik_model_generator/src/base_fabrik_model/base_fabrik_model_config.dart';
import 'package:fabrik_model_generator/src/base_fabrik_model/base_fabrik_model_utils.dart';
import 'package:meta/meta.dart';

/// {@template base_fabrik_model}
/// A base class to facilitate [operator ==] and [hashCode] overrides.
///
/// ```dart
/// class Person extends BaseFabrikModel {
///   const Person(this.name);
///
///   final String name;
///
///   @override
///   List<Object> get props => [name];
/// }
/// ```
/// {@endtemplate}
@immutable
abstract class BaseFabrikModel {
  /// {@macro base_fabrik_model}
  const BaseFabrikModel();

  /// {@template base_fabrik_model_props}
  /// The list of properties that will be used to determine whether
  /// two instances are equal.
  /// {@endtemplate}
  List<Object?> get props;

  /// {@template base_fabrik_model_stringify}
  /// If set to `true`, the [toString] method will be overridden to output
  /// this instance's [props].
  ///
  /// A global default value for [stringify] can be set using
  /// `BaseFabrikModelConfig.stringify`.
  ///
  /// If this instance's [stringify] is set to null, the value of
  /// `BaseFabrikModelConfig.stringify` will be used instead. This defaults to
  /// `false`.
  /// {@endtemplate}
  // ignore: avoid_returning_null
  bool? get stringify => null;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is BaseFabrikModel &&
            runtimeType == other.runtimeType &&
            iterableEquals(props, other.props);
  }

  @override
  int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode(props);

  @override
  String toString() {
    if (stringify ?? BaseFabrikModelConfig.stringify) {
      return mapPropsToString(runtimeType, props);
    }
    return '$runtimeType';
  }
}
