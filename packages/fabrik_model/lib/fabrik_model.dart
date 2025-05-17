import 'package:json_annotation/json_annotation.dart';

export 'package:json_annotation/json_annotation.dart';
export 'package:meta/meta.dart';

part 'fabrik_model.g.dart';

/// {@template fabrik_model.fabrik_model}
/// Flags a class as needing to be processed by FabrikModel.
/// This is a simplified version that just marks a class for code generation.
/// {@endtemplate}
@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
  anyMap: true,
)
class FabrikModel {
  /// {@macro fabrik_model.fabrik_model}
  const FabrikModel({this.fromJson = true, this.toJson = true});

  factory FabrikModel.fromJson(Map json) => _$FabrikModelFromJson(json);

  /// Whether to generate fromJson method
  final bool fromJson;

  /// Whether to generate toJson method
  final bool toJson;
}

/// Default instance of [FabrikModel]
const fabrikModel = FabrikModel();

/// {@template fabrik_model.fabrik_field}
/// Annotation for fields in a FabrikModel class.
/// Allows customization of how fields are handled during serialization.
/// {@endtemplate}
@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
  anyMap: true,
)
class FabrikField {
  /// {@macro fabrik_model.fabrik_field}
  const FabrikField({
    this.defaultValue,
    this.includeFromJson = true,
    this.includeToJson = true,
    this.name,
  });

  factory FabrikField.fromJson(Map json) => _$FabrikFieldFromJson(json);

  /// Default value for the field
  final Object? defaultValue;

  /// Whether to include this field in fromJson deserialization
  final bool includeFromJson;

  /// Whether to include this field in toJson serialization
  final bool includeToJson;

  /// Custom name for the field in JSON
  final String? name;
}

/// Default instance of [FabrikField]
const fabrikField = FabrikField();
