import 'package:fabrik_model_generator/src/base_fabrik_model/base_fabrik_model_config.dart';
import 'package:fabrik_model_generator/src/base_fabrik_model/base_fabrik_model_utils.dart';
import 'package:meta/meta.dart';

/// A mixin that helps implement equality
/// without needing to explicitly override [operator ==] and [hashCode].
///
/// Like with extending [Equatable], the [EquatableMixin] overrides the
/// [operator ==] as well as the [hashCode] based on the provided [props].
@immutable
mixin EquatableMixin {
  /// {@macro equatable_props}
  List<Object?> get props;

  /// {@macro equatable_stringify}
  // ignore: avoid_returning_null
  bool? get stringify => null;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is EquatableMixin &&
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
