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

  Class _generateFromJson(ClassElement classElement, List<_Field> fields) {
    final fromJsonFields = fields.where((f) => f.includeFromJson);

    return Class(
      (b) =>
          b
            ..name = '_\$${classElement.name}FromJson'
            ..abstract = true
            ..methods.add(
              Method(
                (b) =>
                    b
                      ..name = 'fromJson'
                      ..static = true
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
                                  return Code(
                                    '  ${field.name}: json[\'$jsonName\'] as ${field.type.getDisplayString()},',
                                  );
                                }),
                                Code(');'),
                              ]),
                      ),
              ),
            ),
    );
  }

  Class _generateToJson(ClassElement classElement, List<_Field> fields) {
    final toJsonFields = fields.where((f) => f.includeToJson);

    return Class(
      (b) =>
          b
            ..name = '_\$${classElement.name}ToJson'
            ..abstract = true
            ..methods.add(
              Method(
                (b) =>
                    b
                      ..name = 'toJson'
                      ..static = true
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
                                Code('return {'),
                                ...toJsonFields.map((field) {
                                  final jsonName = field.jsonName ?? field.name;
                                  return Code(
                                    '  \'$jsonName\': instance.${field.name},',
                                  );
                                }),
                                Code('};'),
                              ]),
                      ),
              ),
            ),
    );
  }

  Class _generateCopyWith(ClassElement classElement, List<_Field> fields) {
    return Class(
      (b) =>
          b
            ..name = '_\$${classElement.name}CopyWith'
            ..abstract = true
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
                                  ..type = refer(field.type.getDisplayString())
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
            ..abstract = true
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
                                ..type = refer(classElement.name),
                        ),
                        Parameter(
                          (b) =>
                              b
                                ..name = 'b'
                                ..type = refer(classElement.name),
                        ),
                      ])
                      ..body = Block(
                        (b) =>
                            b
                              ..statements.addAll([
                                Code('if (identical(a, b)) return true;'),
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
