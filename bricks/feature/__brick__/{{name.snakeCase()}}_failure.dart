class {{name.pascalCase()}}Failure implements Exception {
  {{name.pascalCase()}}Failure(this.message);

  final String message;

  @override
  String toString() => '{{name.pascalCase()}}Failure: $message';
}