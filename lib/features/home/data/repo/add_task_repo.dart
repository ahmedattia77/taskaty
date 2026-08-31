import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:taskaty/core/constants/networking/api_constants.dart';
import 'package:taskaty/core/errors/failure.dart';
import 'package:taskaty/features/home/data/model/add_task_request_body.dart';

class AddTaskRepo {
  Dio dio;

  AddTaskRepo(this.dio);

  Future<Either<Failure, Unit>> addTask(AddTaskRequestBody body) async {
    try {
      final response = await dio.post(
        ApiConstants.addTaskEndPoint,
        data: body.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return const Right(unit);
      } else {
        return Left(
          ServerFailure.fromResponse(response.statusCode, response.data),
        );
      }
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
