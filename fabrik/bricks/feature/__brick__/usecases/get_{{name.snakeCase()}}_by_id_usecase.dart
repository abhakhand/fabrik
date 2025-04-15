import 'package:dartz/dartz.dart';
import '../entities/entities.dart';
import '../{{name.snakeCase()}}_repository.dart';
import 'package:flutter_core/flutter_core.dart';


class Get{{name.pascalCase()}}ByIdUsecase {
  const Get{{name.pascalCase()}}ByIdUsecase(this._repository);

  final I{{name.pascalCase()}}Repository _repository;

  Future<Either<Failure, {{name.pascalCase()}}>> call(String id) {
    return _repository.get{{name.pascalCase()}}ById(id);
  }
}
