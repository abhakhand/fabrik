import 'package:analyzer/dart/element/element.dart';
import 'package:fabrik_model/fabrik_model.dart';
import 'package:source_gen/source_gen.dart';

class ParsedField {
  final String name;
  final String type;
  final bool isNullable;
  final Object? defaultValue;
  final bool includeToJson;
  final bool includeFromJson;

  ParsedField({
    required this.name,
    required this.type,
    required this.isNullable,
    this.defaultValue,
    required this.includeToJson,
    required this.includeFromJson,
  });
}

class ParsedModel {
  final String className;
  final String constructorName;
  final List<ParsedField> fields;

  ParsedModel({
    required this.className,
    required this.constructorName,
    required this.fields,
  });
}

class FabrikModelVisitor {
  ParsedModel visit(ClassElement element, ConstantReader annotation) {
    final constructor = element.unnamedConstructor;
    final fields = <ParsedField>[];

    for (final param in constructor!.parameters) {
      final fieldAnnotation = TypeChecker.fromRuntime(
        Field,
      ).firstAnnotationOfExact(param);

      final reader =
          fieldAnnotation != null ? ConstantReader(fieldAnnotation) : null;

      final defaultValue = reader?.peek('defaultValue')?.literalValue;
      final includeToJson = reader?.peek('includeToJson')?.boolValue ?? true;
      final includeFromJson =
          reader?.peek('includeFromJson')?.boolValue ?? true;

      fields.add(
        ParsedField(
          name: param.name,
          type: param.type.getDisplayString(),
          isNullable: param.type.nullabilitySuffix.name != 'none',
          defaultValue: defaultValue,
          includeToJson: includeToJson,
          includeFromJson: includeFromJson,
        ),
      );
    }

    final emptyConstructorName =
        annotation.peek('emptyConstructorName')?.stringValue ?? 'empty';

    return ParsedModel(
      className: element.name,
      constructorName: emptyConstructorName,
      fields: fields,
    );
  }
}
