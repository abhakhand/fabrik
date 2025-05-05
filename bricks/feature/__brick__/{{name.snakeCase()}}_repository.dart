import 'package:dartz/dartz.dart';
import 'entities/entities.dart';
import './{{name.snakeCase()}}_failure.dart';

abstract class I{{name.pascalCase()}}Repository {
  Future<Either<{{name.pascalCase()}}Failure, {{name.pascalCase()}}>> get{{name.pascalCase()}}ById(String id);
}

 class {{name.pascalCase()}}Repository implements I{{name.pascalCase()}}Repository {
  @override
  Future<Either<{{name.pascalCase()}}Failure, {{name.pascalCase()}}>> get{{name.pascalCase()}}ById(String id) async {}
}
