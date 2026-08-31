import 'package:dartz/dartz.dart';
import 'package:taskaty/core/errors/failure.dart';
import 'package:taskaty/features/home/data/model/add_task_request_body.dart';
import 'package:taskaty/features/home/data/repo/add_task_repo.dart';

class AddTaskUseCase {
  AddTaskRepo addTaskRepo;

  AddTaskUseCase(this.addTaskRepo);

  Future<Either<Failure, Unit>> call(AddTaskRequestBody body) async {
    return await addTaskRepo.addTask(body);
  }
}
