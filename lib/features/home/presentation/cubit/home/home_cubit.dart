import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:taskaty/features/home/data/model/task_response_model.dart';
import 'package:taskaty/features/home/data/use_case/get_tasks_use_case.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetTasksUseCase getTasksUseCase;

  HomeCubit(this.getTasksUseCase) : super(HomeTaskInitial());

  String? currentStartDate;
  String? currentEndDate;
  String? currentPriority;

  Future<void> fetchTasks({
    String? startDate,
    String? endDate,
    String? priority,
  }) async {
    currentStartDate = startDate;
    currentEndDate = endDate;
    currentPriority = priority;

    emit(HomeTaskLoading());

    final result = await getTasksUseCase.call(
      startDate: startDate,
      endDate: endDate,
      priority: priority,
    );

    result.fold(
      (failure) => emit(HomeTaskFialer(failure.errMessage)),
      (response) => emit(HomeTaskSuccess(response)),
    );
  }

  void clearFilter() {
    currentStartDate = null;
    currentEndDate = null;
    currentPriority = null;

    fetchTasks();
  }
}
