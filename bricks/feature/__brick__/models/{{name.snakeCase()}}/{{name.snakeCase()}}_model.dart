import 'package:json_annotation/json_annotation.dart';

part '{{name.snakeCase()}}_model.g.dart';

@JsonSerializable()
class {{name.pascalCase()}}Model {
  const {{name.pascalCase()}}Model({
    this.id = '',
    this.name = '',
  });

  factory {{name.pascalCase()}}Model.fromJson(Map<String, dynamic> json) =>
      _${{name.pascalCase()}}ModelFromJson(json);

  Map<String, dynamic> toJson() => _${{name.pascalCase()}}ModelToJson(this);

  final String id;
  final String name;

  static const empty = {{name.pascalCase()}}Model();
  bool get isEmpty => this == empty;
  bool get isNotEmpty => this != empty;

  {{name.pascalCase()}} get toEntity => {{name.pascalCase()}}(
        id: id,
        name: name,
      );
}
