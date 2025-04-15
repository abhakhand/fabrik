import 'package:dartz/dartz.dart';
import 'entities/entities.dart';
import 'package:flutter_core/flutter_core.dart';

abstract class I{{name.pascalCase()}}Repository {
  Future<Either<Failure, {{name.pascalCase()}}>> get{{name.pascalCase()}}ById(String id);
}

 class {{name.pascalCase()}}Repository implements I{{name.pascalCase()}}Repository {
  @override
  Future<Either<Failure, {{name.pascalCase()}}>> get{{name.pascalCase()}}ById(String id) async {}
}
