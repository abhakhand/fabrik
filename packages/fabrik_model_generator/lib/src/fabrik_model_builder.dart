import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'fabrik_model_generator.dart';

Builder fabrikModelBuilder(BuilderOptions options) {
  return PartBuilder([FabrikModelGenerator()], '.fmodel.dart');
}
