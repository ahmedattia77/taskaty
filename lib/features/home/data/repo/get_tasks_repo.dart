import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:taskaty/core/constants/networking/api_constants.dart';
import 'package:taskaty/core/errors/failure.dart';
import 'package:taskaty/features/home/data/model/task_response_model.dart';

class GetTaskRepo {
  Dio dio;

  GetTaskRepo(this.dio);
  Future<Either<Failure, TaskResponseModel>> getTasks({
    String? startDate,
    String? endDate,
    String? priority,
  }) async {
    try {
      final response = await dio.get(
        ApiConstants.getAllTasksEndPoint,
        queryParameters: {
          if (startDate != null) 'start': startDate,
          if (endDate != null) 'end': endDate,
          if (priority != null) 'priority': priority,
        },
      );
      return Right(TaskResponseModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
