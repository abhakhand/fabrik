import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:fabrik_model/fabrik_model.dart';
import 'package:source_gen/source_gen.dart';
import 'json_serialization.dart';

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
              JsonSerializationGenerator.generateFromJson(classElement, fields),
              JsonSerializationGenerator.generateToJson(classElement, fields),
            ]),
    );

    final emitter = DartEmitter();
    final code = library.accept(emitter);
    final formatter = DartFormatter();
    return formatter.format('$code');
  }

  List<FieldElement> _getFields(ClassElement classElement) {
    return classElement.fields
        .where((field) => !field.isStatic && !field.isPrivate)
        .toList();
  }
}
