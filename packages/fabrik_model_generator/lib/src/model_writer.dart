import 'model_visitor.dart';

String generateModelCode(ParsedModel model) {
  final buffer = StringBuffer();

  final className = model.className;
  // final privateClassName = '_$className';
  final emptyCtorName = model.constructorName;

  // PART HEADER
  buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND\n');

  // Extension
  buffer.writeln('extension ${className}Helpers on $className {');

  // fromJson
  buffer.writeln('  static $className fromJson(Map<String, dynamic> json) {');
  buffer.writeln('    return $className(');
  for (final field in model.fields.where((f) => f.includeFromJson)) {
    final fallback = _generateFallback(field);
    buffer.writeln("      ${field.name}: $fallback,");
  }
  buffer.writeln('    );');
  buffer.writeln('  }');

  // toJson
  buffer.writeln('  Map<String, dynamic> toJson() {');
  buffer.writeln('    return {');
  for (final field in model.fields.where((f) => f.includeToJson)) {
    buffer.writeln("      '${field.name}': ${field.name},");
  }
  buffer.writeln('    };');
  buffer.writeln('  }');

  // copyWith
  buffer.writeln('  $className copyWith({');
  for (final field in model.fields) {
    buffer.writeln(
      "    ${field.type}${field.isNullable ? '?' : ''} ${field.name},",
    );
  }
  buffer.writeln('  }) {');
  buffer.writeln('    return $className(');
  for (final field in model.fields) {
    buffer.writeln("      ${field.name}: ${field.name} ?? this.${field.name},");
  }
  buffer.writeln('    );');
  buffer.writeln('  }');

  // isEmpty / isNotEmpty
  buffer.writeln('  static const $className $emptyCtorName = $className(');
  for (final field in model.fields) {
    final defaultVal = _dartLiteral(field.defaultValue);
    buffer.writeln("    ${field.name}: $defaultVal,");
  }
  buffer.writeln('  );');
  buffer.writeln('  bool get isEmpty => this == $className.$emptyCtorName;');
  buffer.writeln('  bool get isNotEmpty => !isEmpty;');

  buffer.writeln('}');

  return buffer.toString();
}

String _generateFallback(ParsedField field) {
  final name = field.name;
  final type = field.type;

  // fallback if null in json
  if (field.defaultValue != null) {
    final fallback = _dartLiteral(field.defaultValue);
    return "(json['$name'] == null) ? $fallback : json['$name'] as $type";
  }

  // if no defaultValue, just cast (unsafe if field is required and null is received)
  return "json['$name'] as $type";
}

String _dartLiteral(Object? value) {
  if (value == null) return 'null';
  if (value is String) return "'$value'";
  if (value is List) return 'const []';
  return value.toString();
}
