import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../../../bricks/feature/__brick__/entities/{{name.snakeCase()}}/{{name.snakeCase()}}.freezed.dart';

@freezed
class {{name.pascalCase()}} with _${{name.pascalCase()}} {
  const factory {{name.pascalCase()}}({
    @Default('') String id,
  }) = _{{name.pascalCase()}};

  const {{name.pascalCase()}}._();

  static const empty = {{name.pascalCase()}}();
  bool get isEmpty => this == empty;
  bool get isNotEmpty => this != empty;
}
