import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:taskaty/features/home/data/model/task_response_model.dart';
import 'package:taskaty/features/home/data/use_case/get_tasks_use_case.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetTasksUseCase getTasksUseCase;
  HomeCubit(this.getTasksUseCase) : super(HomeTaskInitial());

  Future<void> fetchTasks() async {
    emit(HomeTaskLoading());

    final result = await getTasksUseCase.call();

    result.fold(
      (failure) => emit(HomeTaskFialer(failure.errMessage)),
      (response) => emit(HomeTaskSuccess(response)),
    );
  }
}
