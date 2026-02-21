/// A helper class for converting strings into various casing styles.
///
/// `FabrikCasing` intelligently splits a string into logical word segments
/// and offers multiple output formats like `camelCase`, `snake_case`, `PascalCase`,
/// and more.
class FabrikCasing {
  FabrikCasing(String input) {
    _segments = _extractWords(input);
  }

  final _upperCasePattern = RegExp(r'[A-Z]');
  final _delimiters = {' ', '.', '/', '_', '\\', '-'};

  late final List<String> _segments;

  /// Splits the input string into word segments based on delimiters and casing.
  List<String> _extractWords(String input) {
    final buffer = StringBuffer();
    final words = <String>[];
    final isAllCaps = input.toUpperCase() == input;

    for (var i = 0; i < input.length; i++) {
      final char = input[i];
      final nextChar = i + 1 < input.length ? input[i + 1] : null;

      if (_delimiters.contains(char)) continue;

      buffer.write(char);

      final isWordEnd =
          nextChar == null ||
          (_upperCasePattern.hasMatch(nextChar) && !isAllCaps) ||
          _delimiters.contains(nextChar);

      if (isWordEnd) {
        words.add(buffer.toString());
        buffer.clear();
      }
    }

    return words.where((s) => s.isNotEmpty).toList();
  }

  /// Converts to Title Case (e.g., "Hello World")
  String get title => _buildPascal(separator: ' ');

  /// Converts to Header-Case (e.g., "Hello-World")
  String get header => _buildPascal(separator: '-');

  /// Converts to PascalCase (e.g., "HelloWorld")
  String get pascal => _buildPascal();

  /// Converts to camelCase (e.g., "helloWorld")
  String get camel => _buildCamel();

  /// Converts to snake_case (e.g., "hello_world")
  String get snake => _buildSeparated('_');

  /// Converts to CONSTANT_CASE (e.g., "HELLO_WORLD")
  String get constant => _buildSeparated('_', upper: true);

  /// Converts to kebab-case (e.g., "hello-world")
  String get kebab => _buildSeparated('-');

  /// Converts to dot.case (e.g., "hello.world")
  String get dotted => _buildSeparated('.');

  /// Converts to path/case (e.g., "hello/world")
  String get path => _buildSeparated('/');

  /// Converts to Sentence case (e.g., "Hello world")
  String get sentence => _buildSentence();

  String _capitalize(String value) {
    return '${value[0].toUpperCase()}${value.substring(1).toLowerCase()}';
  }

  String _buildCamel() {
    final words = _segments.map(_capitalize).toList();
    if (words.isNotEmpty) {
      words[0] = words[0].toLowerCase();
    }
    return words.join();
  }

  String _buildPascal({String separator = ''}) {
    return _segments.map(_capitalize).join(separator);
  }

  String _buildSentence({String separator = ' '}) {
    final words = _segments.map((w) => w.toLowerCase()).toList();
    if (words.isNotEmpty) {
      words[0] = _capitalize(words[0]);
    }
    return words.join(separator);
  }

  String _buildSeparated(String separator, {bool upper = false}) {
    final words =
        upper
            ? _segments.map((w) => w.toUpperCase())
            : _segments.map((w) => w.toLowerCase());
    return words.join(separator);
  }
}

/// Extension on [String?] to add null and blank checks.
extension NullableStringX on String? {
  /// Returns `true` if the string is `null`, empty, or only whitespace.
  ///
  /// Examples:
  /// ```dart
  /// String? a = null;
  /// a.isNullOrBlank → true
  ///
  /// String? b = '';
  /// b.isNullOrBlank → true
  ///
  /// String? c = '   ';
  /// c.isNullOrBlank → true
  ///
  /// String? d = 'hello';
  /// d.isNullOrBlank → false
  /// ```
  bool get isNullOrBlank => this == null || this!.trim().isEmpty;
}

/// Extension on `String` to easily access Fabrik casing styles and other helpers.
extension StringX on String {
  /// Converts the string to Title Case (e.g., "Hello World")
  /// Returns a copy of the string with only the first letter capitalized,
  /// and the rest in lowercase.
  ///
  /// Example:
  /// ```dart
  /// 'hello WORLD'.capitalizeFirst → "Hello world"
  /// ```
  String get capitalizeFirst {
    if (isEmpty) return this;
    if (length == 1) return toUpperCase();
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  /// Converts the string to Title-Case (e.g., "Hello World")
  String get titleCase => FabrikCasing(this).title;

  /// Converts the string to Header-Case (e.g., "Hello-World")
  String get headerCase => FabrikCasing(this).header;

  /// Converts the string to PascalCase (e.g., "HelloWorld")
  String get pascalCase => FabrikCasing(this).pascal;

  /// Converts the string to camelCase (e.g., "helloWorld")
  String get camelCase => FabrikCasing(this).camel;

  /// Converts the string to snake_case (e.g., "hello_world")
  String get snakeCase => FabrikCasing(this).snake;

  /// Converts the string to kebab-case (e.g., "hello-world")
  String get kebabCase => FabrikCasing(this).kebab;

  /// Converts the string to dot.case (e.g., "hello.world")
  String get dottedCase => FabrikCasing(this).dotted;

  /// Converts the string to path/case (e.g., "hello/world")
  String get pathCase => FabrikCasing(this).path;

  /// Converts the string to Sentence case (e.g., "Hello world")
  String get sentenceCase => FabrikCasing(this).sentence;

  /// Converts the string to CONSTANT_CASE (e.g., "HELLO_WORLD")
  String get constantCase => FabrikCasing(this).constant;
}
