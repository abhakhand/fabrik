import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:fabrik_model/fabrik_model.dart';
import 'package:source_gen/source_gen.dart';

class FabrikModelGenerator extends GeneratorForAnnotation<FabrikModel> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        '`@FabrikModel()` can only be applied to classes.',
        element: element,
      );
    }

    final classElement = element;
    final fields = _getFields(classElement);

    final library = Library(
      (b) =>
          b
            ..body.addAll([
              _generateFromJson(classElement, fields),
              _generateToJson(classElement, fields),
              _generateCopyWith(classElement, fields),
              _generateEquality(classElement, fields),
            ]),
    );

    final emitter = DartEmitter();
    final code = library.accept(emitter);
    final formatter = DartFormatter();
    return formatter.format('$code');
  }

  List<_Field> _getFields(ClassElement classElement) {
    return classElement.fields
        .where((field) => !field.isStatic && !field.isPrivate)
        .map((field) {
          final fabrikField = const TypeChecker.fromRuntime(
            FabrikField,
          ).firstAnnotationOf(field);

          return _Field(
            name: field.name,
            type: field.type,
            defaultValue: fabrikField?.getField('defaultValue')?.toBoolValue(),
            includeFromJson:
                fabrikField?.getField('includeFromJson')?.toBoolValue() ?? true,
            includeToJson:
                fabrikField?.getField('includeToJson')?.toBoolValue() ?? true,
            jsonName: fabrikField?.getField('name')?.toStringValue(),
          );
        })
        .toList();
  }

  Spec _generateFromJson(ClassElement classElement, List<_Field> fields) {
    final fromJsonFields = fields.where((f) => f.includeFromJson);

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
                        final jsonName = field.jsonName ?? field.name;
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

  Spec _generateToJson(ClassElement classElement, List<_Field> fields) {
    final toJsonFields = fields.where((f) => f.includeToJson);

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
                        final jsonName = field.jsonName ?? field.name;
                        return Code('  \'$jsonName\': instance.${field.name},');
                      }),
                      Code('};'),
                    ]),
            ),
    );
  }

  String _getDefaultValueForType(String type) {
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

  Class _generateCopyWith(ClassElement classElement, List<_Field> fields) {
    return Class(
      (b) =>
          b
            ..name = '_\$${classElement.name}CopyWith'
            ..methods.add(
              Method(
                (b) =>
                    b
                      ..name = 'copyWith'
                      ..returns = refer(classElement.name)
                      ..requiredParameters.add(
                        Parameter(
                          (b) =>
                              b
                                ..name = 'instance'
                                ..type = refer(classElement.name),
                        ),
                      )
                      ..optionalParameters.addAll(
                        fields.map(
                          (field) => Parameter(
                            (b) =>
                                b
                                  ..name = field.name
                                  ..type = refer(
                                    '${field.type.getDisplayString()}?',
                                  )
                                  ..named = true,
                          ),
                        ),
                      )
                      ..body = Block(
                        (b) =>
                            b
                              ..statements.addAll([
                                Code('return ${classElement.name}('),
                                ...fields.map(
                                  (field) => Code(
                                    '  ${field.name}: ${field.name} ?? instance.${field.name},',
                                  ),
                                ),
                                Code(');'),
                              ]),
                      ),
              ),
            ),
    );
  }

  Class _generateEquality(ClassElement classElement, List<_Field> fields) {
    return Class(
      (b) =>
          b
            ..name = '_\$${classElement.name}Equality'
            ..methods.addAll([
              Method(
                (b) =>
                    b
                      ..name = 'operator =='
                      ..returns = refer('bool')
                      ..requiredParameters.addAll([
                        Parameter(
                          (b) =>
                              b
                                ..name = 'a'
                                ..type = refer('Object'),
                        ),
                        Parameter(
                          (b) =>
                              b
                                ..name = 'b'
                                ..type = refer('Object'),
                        ),
                      ])
                      ..body = Block(
                        (b) =>
                            b
                              ..statements.addAll([
                                Code('if (identical(a, b)) return true;'),
                                Code(
                                  'if (a is! ${classElement.name} || b is! ${classElement.name}) return false;',
                                ),
                                Code('return '),
                                ...fields.map(
                                  (field) => Code(
                                    'a.${field.name} == b.${field.name} &&',
                                  ),
                                ),
                                Code('true;'),
                              ]),
                      ),
              ),
              Method(
                (b) =>
                    b
                      ..name = 'hashCode'
                      ..returns = refer('int')
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
                                Code('return Object.hash('),
                                ...fields.map(
                                  (field) => Code('instance.${field.name},'),
                                ),
                                Code(');'),
                              ]),
                      ),
              ),
            ]),
    );
  }
}

class _Field {
  final String name;
  final DartType type;
  final Object? defaultValue;
  final bool includeFromJson;
  final bool includeToJson;
  final String? jsonName;

  const _Field({
    required this.name,
    required this.type,
    this.defaultValue,
    this.includeFromJson = true,
    this.includeToJson = true,
    this.jsonName,
  });
}
