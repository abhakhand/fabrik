import 'dart:io';
import 'package:args/args.dart';
import 'package:mason/mason.dart';

final _logger = Logger();

/// Entry point for Fabrik CLI.
///
/// Run this using:
/// ```bash
/// dart run bin/fabrik.dart generate feature <name>
/// ```
Future<void> main(List<String> args) async {
  final parser = ArgParser()..addFlag('help', abbr: 'h', help: 'Print usage');

  final generateCmd = ArgParser()
    ..addOption(
      'output-dir',
      abbr: 'o',
      help: 'Directory where the generated code should be placed.',
    );

  parser.addCommand('generate', generateCmd);

  final results = parser.parse(args);

  if (results['help'] == true || results.command == null) {
    _printUsage(parser);
    exit(0);
  }

  final command = results.command;

  if (command?.name == 'generate') {
    final rest = command!.rest;

    if (rest.length < 2 || rest[0] != 'feature') {
      _logger.err('❌ Usage: fabrik generate feature <name>');
      exit(1);
    }

    final featureName = rest[1];
    final outputDir = command['output-dir'] ?? featureName;

    final generator = await loadFeatureGenerator();

    final target = DirectoryGeneratorTarget(
      Directory(normalizePath(outputDir)),
    );
    final vars = <String, dynamic>{'name': featureName};

    _logger.info('🔨 Generating feature: $featureName...\n');
    await generator.generate(target, vars: vars);
    _logger.success(
      '✅ Feature "$featureName" generated successfully at $outputDir',
    );
  } else {
    _logger.err('❌ Unknown command: ${command?.name}');
    _printUsage(parser);
  }
}

void _printUsage(ArgParser parser) {
  _logger.info('🧱 Fabrik CLI - Generate Flutter feature scaffolding');
  _logger.info(
    '\nUsage:\n  fabrik generate feature <name> [--output-dir|-o <path>]\n',
  );
  _logger.info(parser.usage);
}

Future<MasonGenerator> loadFeatureGenerator() async {
  final bundleFile = File('lib/src/bricks/feature.bundle');

  if (!await bundleFile.exists()) {
    throw Exception('❌ Brick bundle not found: ${bundleFile.path}');
  }

  final bytes = await bundleFile.readAsBytes();
  final bundle = await MasonBundle.fromUniversalBundle(bytes);

  return MasonGenerator.fromBundle(bundle);
}

String normalizePath(String path) {
  if (path.startsWith('./') || path.startsWith('/')) return path;
  return './$path';
}
