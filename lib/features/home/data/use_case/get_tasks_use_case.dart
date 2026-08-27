import 'package:dartz/dartz.dart';
import 'package:taskaty/core/errors/failure.dart';
import 'package:taskaty/features/home/data/model/task_response_model.dart';
import 'package:taskaty/features/home/data/repo/get_tasks_repo.dart';

class GetTasksUseCase {
  final GetTaskRepo taskRepo;

  GetTasksUseCase(this.taskRepo);

  Future<Either<Failure, TaskResponseModel>> call() async {
    return await taskRepo.getTasks();
  }
}
