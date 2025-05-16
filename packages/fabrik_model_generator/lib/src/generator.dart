import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:fabrik_model/fabrik_model.dart';

import 'model_visitor.dart';
import 'model_writer.dart';

class FabrikModelGenerator extends GeneratorForAnnotation<FabrikModel> {
  @override
  generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        '`@FabrikModel` can only be used on a class.',
        element: element,
      );
    }

    final visitor = FabrikModelVisitor();
    final parsedModel = visitor.visit(element, annotation);
    return generateModelCode(parsedModel);
  }
}
