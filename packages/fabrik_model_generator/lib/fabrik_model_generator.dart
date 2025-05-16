import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/generator.dart';

Builder fabrikModelBuilder(BuilderOptions options) =>
    SharedPartBuilder([FabrikModelGenerator()], 'fabrik_model');
