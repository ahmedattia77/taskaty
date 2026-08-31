import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:taskaty/features/home/data/model/add_task_request_body.dart';
import 'package:taskaty/features/home/data/use_case/add_task_use_case.dart';

part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskUseCase addTaskUseCase;
  AddTaskCubit(this.addTaskUseCase) : super(AddTaskInitial());

  Future<void> addTask(AddTaskRequestBody body) async {
    emit(AddTaskLoading());
    final result = await addTaskUseCase.call(body);

    result.fold(
      (failure) => emit(AddTaskFailure(failure.errMessage)),
      (success) => emit(AddTaskSuccess()),
    );
  }
}
