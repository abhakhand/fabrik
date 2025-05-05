import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../entities/entities.dart';
import '../usecases/usecases.dart';

part '{{name.snakeCase()}}_event.dart';
part '{{name.snakeCase()}}_state.dart';

enum {{name.pascalCase()}}Status { 
  initial, 
  loading, 
  success, 
  failure,
}

class {{name.pascalCase()}}Bloc extends Bloc<{{name.pascalCase()}}Event, {{name.pascalCase()}}State> {
  {{name.pascalCase()}}Bloc(this._get{{name.pascalCase()}}ByIdUsecase)
      : super(const {{name.pascalCase()}}State()) {
    on<{{name.pascalCase()}}Requested>(_onRequested);
  }

  final Get{{name.pascalCase()}}ByIdUsecase _get{{name.pascalCase()}}ByIdUsecase;

  Future<void> _onRequested(
    {{name.pascalCase()}}Requested event,
    Emitter<{{name.pascalCase()}}State> emit,
  ) async {
    emit(state.copyWith(status: {{name.pascalCase()}}Status.loading));

    final result = await _get{{name.pascalCase()}}ByIdUsecase(event.id);
    
    emit(result.fold(
      (f) => state.copyWith(status: {{name.pascalCase()}}Status.failure),
      (data) => state.copyWith(
        status: {{name.pascalCase()}}Status.success,
        data: data,
      ),
    ));
  }
}
