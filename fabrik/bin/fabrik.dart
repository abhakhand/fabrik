import 'dart:io';
import 'dart:isolate';
import 'package:args/args.dart';
import 'package:mason/mason.dart';

final _logger = Logger();

/// 🧱 Entry point for Fabrik CLI.
///
/// This command-line interface is used to generate Flutter feature scaffolding
/// using the DDD layered architecture.
///
/// ### Usage
///
/// Generate a feature:
/// ```bash
/// fabrik generate feature <name>
/// ```
///
/// Specify a custom output directory:
/// ```bash
/// fabrik generate feature <name> --output-dir|-o <path>
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

  // 🧱 Handle "generate" command
  if (command?.name == 'generate') {
    final rest = command!.rest;

    if (rest.length < 2 || rest[0] != 'feature') {
      _logger.err('❌ Usage: fabrik generate feature <name>');
      exit(1);
    }

    final featureName = rest[1];
    final outputDir = command['output-dir'] ?? featureName;

    // 🔄 Load the brick bundle (compiled template)
    final generator = await loadFeatureGenerator();

    // 📁 Define target output directory
    final target = DirectoryGeneratorTarget(
      Directory(normalizePath(outputDir)),
    );

    final vars = <String, dynamic>{'name': featureName};

    // 🛠️ Generate feature
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

/// Prints usage information for the CLI.
void _printUsage(ArgParser parser) {
  _logger.info('🧱 Fabrik CLI - Generate Flutter feature scaffolding');
  _logger.info(
    '\nUsage:\n  fabrik generate feature <name> [--output-dir|-o <path>]\n',
  );
  _logger.info(parser.usage);
}

/// Loads the pre-compiled Mason brick bundle for the feature generator.
///
/// Returns a [MasonGenerator] ready to generate the feature scaffold.
Future<MasonGenerator> loadFeatureGenerator() async {
  // 🧱 Resolve bundle path from package
  final resolvedUri = await Isolate.resolvePackageUri(
    Uri.parse('package:fabrik/src/bricks/feature.bundle'),
  );

  if (resolvedUri == null) {
    throw Exception('❌ Failed to resolve feature.bundle from package.');
  }

  final bundleFile = File.fromUri(resolvedUri);

  if (!await bundleFile.exists()) {
    throw Exception('❌ Brick bundle not found at ${bundleFile.path}');
  }

  // 📦 Load the Mason bundle from binary
  final bytes = await bundleFile.readAsBytes();
  final bundle = await MasonBundle.fromUniversalBundle(bytes);

  return MasonGenerator.fromBundle(bundle);
}

/// Normalizes a directory path by prepending './' if it's a plain name.
///
/// Helps ensure correct relative path resolution for generated files.
String normalizePath(String path) {
  if (path.startsWith('./') || path.startsWith('/')) return path;
  return './$path';
}
