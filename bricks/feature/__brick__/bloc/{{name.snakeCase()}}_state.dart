part of '{{name.snakeCase()}}_bloc.dart';

class {{name.pascalCase()}}State extends Equatable {
  const {{name.pascalCase()}}State({
    this.status = const Status.initial(),
    this.data = const {{name.pascalCase()}}(),
  });

  final Status status;
  final {{name.pascalCase()}} data;

  @override
  List<Object> get props => [status, data];

  {{name.pascalCase()}}State copyWith({
    Status? status,
    {{name.pascalCase()}}? data,
  }) {
    return {{name.pascalCase()}}State(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }
}
