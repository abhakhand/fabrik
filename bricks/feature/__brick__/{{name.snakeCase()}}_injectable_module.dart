import 'package:injectable/injectable.dart';

@module {{name.pascalCase()}}InjectableModule {
  @LazySingleton(as: I{{name.pascalCase()}DataSource)
  {{name.pascalCase()}DataSource get {{name.camelCase()}DataSource =>
      {{name.pascalCase()}DataSource();

  @LazySingleton(as: I{{name.pascalCase()}Repository)
  {{name.pascalCase()}Repository get {{name.camelCase()}Repository =>
      {{name.pascalCase()}Repository({{name.camelCase()}DataSource);

  @lazySingleton
  Get{{name.pascalCase()}ByIdUsecase get get{{name.pascalCase()}ByIdUsecase =>
      {{name.pascalCase()}ByIdUsecase({{name.camelCase()}Repository);

  @injectable
  {{name.pascalCase()}Bloc get {{name.camelCase()}Bloc =>
      {{name.pascalCase()}Bloc(get{{name.pascalCase()}ByIdUsecase);
}