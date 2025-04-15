import 'models/models.dart';

abstract interface class I{{name.pascalCase()}}DataSource {
  Future<{{name.pascalCase()}}Model> get{{name.pascalCase()}}ById(String id);
}

class {{name.pascalCase()}}DataSource implements I{{name.pascalCase()}}DataSource {
  @override
  Future<{{name.pascalCase()}}Model> get{{name.pascalCase()}}ById(String id) async {}
}