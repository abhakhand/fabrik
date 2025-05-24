import 'package:analyzer/dart/element/element.dart';
import 'package:code_builder/code_builder.dart';
import 'package:fabrik_model/fabrik_model.dart';
import 'package:source_gen/source_gen.dart';

class JsonSerializationGenerator {
  static Spec generateFromJson(
    ClassElement classElement,
    List<FieldElement> fields,
  ) {
    // Check if the class has FabrikModel annotation with fromJson enabled
    final fabrikModel = const TypeChecker.fromRuntime(
      FabrikModel,
    ).firstAnnotationOf(classElement);
    final shouldGenerateFromJson =
        fabrikModel?.getField('fromJson')?.toBoolValue() ?? true;

    if (!shouldGenerateFromJson) {
      return Method(
        (b) =>
            b
              ..name = '_\$${classElement.name}FromJson'
              ..returns = refer(classElement.name)
              ..requiredParameters.add(
                Parameter(
                  (b) =>
                      b
                        ..name = 'json'
                        ..type = refer('Map<String, dynamic>'),
                ),
              )
              ..body = Block(
                (b) =>
                    b
                      ..statements.add(
                        Code(
                          'throw UnimplementedError(\'fromJson is disabled for this class\');',
                        ),
                      ),
              ),
      );
    }

    final fromJsonFields = fields.where((field) {
      final fabrikField = const TypeChecker.fromRuntime(
        FabrikField,
      ).firstAnnotationOf(field);
      return fabrikField?.getField('includeFromJson')?.toBoolValue() ?? true;
    });

    return Method(
      (b) =>
          b
            ..name = '_\$${classElement.name}FromJson'
            ..returns = refer(classElement.name)
            ..requiredParameters.add(
              Parameter(
                (b) =>
                    b
                      ..name = 'json'
                      ..type = refer('Map<String, dynamic>'),
              ),
            )
            ..body = Block(
              (b) =>
                  b
                    ..statements.addAll([
                      Code('return ${classElement.name}('),
                      ...fromJsonFields.map((field) {
                        final fabrikField = const TypeChecker.fromRuntime(
                          FabrikField,
                        ).firstAnnotationOf(field);
                        final jsonName =
                            fabrikField?.getField('name')?.toStringValue() ??
                            field.name;
                        final type = field.type.getDisplayString();
                        final defaultValue = _getDefaultValueForType(type);
                        return Code(
                          '  ${field.name}: json[\'$jsonName\'] as $type? ?? $defaultValue,',
                        );
                      }),
                      Code(');'),
                    ]),
            ),
    );
  }

  static Spec generateToJson(
    ClassElement classElement,
    List<FieldElement> fields,
  ) {
    // Check if the class has FabrikModel annotation with toJson enabled
    final fabrikModel = const TypeChecker.fromRuntime(
      FabrikModel,
    ).firstAnnotationOf(classElement);
    final shouldGenerateToJson =
        fabrikModel?.getField('toJson')?.toBoolValue() ?? true;

    if (!shouldGenerateToJson) {
      return Method(
        (b) =>
            b
              ..name = '_\$${classElement.name}ToJson'
              ..returns = refer('Map<String, dynamic>')
              ..requiredParameters.add(
                Parameter(
                  (b) =>
                      b
                        ..name = 'instance'
                        ..type = refer(classElement.name),
                ),
              )
              ..body = Block(
                (b) =>
                    b
                      ..statements.add(
                        Code(
                          'throw UnimplementedError(\'toJson is disabled for this class\');',
                        ),
                      ),
              ),
      );
    }

    final toJsonFields = fields.where((field) {
      final fabrikField = const TypeChecker.fromRuntime(
        FabrikField,
      ).firstAnnotationOf(field);
      return fabrikField?.getField('includeToJson')?.toBoolValue() ?? true;
    });

    return Method(
      (b) =>
          b
            ..name = '_\$${classElement.name}ToJson'
            ..returns = refer('Map<String, dynamic>')
            ..requiredParameters.add(
              Parameter(
                (b) =>
                    b
                      ..name = 'instance'
                      ..type = refer(classElement.name),
              ),
            )
            ..body = Block(
              (b) =>
                  b
                    ..statements.addAll([
                      Code('return <String, dynamic>{'),
                      ...toJsonFields.map((field) {
                        final fabrikField = const TypeChecker.fromRuntime(
                          FabrikField,
                        ).firstAnnotationOf(field);
                        final jsonName =
                            fabrikField?.getField('name')?.toStringValue() ??
                            field.name;
                        return Code('  \'$jsonName\': instance.${field.name},');
                      }),
                      Code('};'),
                    ]),
            ),
    );
  }

  static String _getDefaultValueForType(String type) {
    switch (type) {
      case 'String':
        return "''";
      case 'int':
        return '0';
      case 'double':
        return '0.0';
      case 'bool':
        return 'false';
      case 'List':
        return '[]';
      case 'Map':
        return '{}';
      default:
        return 'null';
    }
  }
}
