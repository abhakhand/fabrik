import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../entities/entities.dart';
import '../usecases/usecases.dart';
import 'package:flutter_core/flutter_core.dart';

part '{{name.snakeCase()}}_event.dart';
part '{{name.snakeCase()}}_state.dart';

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
    emit(state.copyWith(status: const Status.loading()));

    final result = await _get{{name.pascalCase()}}ByIdUsecase(event.id);
    
    emit(result.fold(
      (f) => state.copyWith(status: Status.failure(f)),
      (data) => state.copyWith(
        status: const Status.success(),
        data: data,
      ),
    ));
  }
}
