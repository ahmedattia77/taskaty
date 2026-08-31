import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:taskaty/core/constants/app_const/key_const.dart';
import 'package:taskaty/core/constants/networking/api_constants.dart';
import 'package:taskaty/core/errors/failure.dart';
import 'package:taskaty/core/services/local_storage.dart';
import 'package:taskaty/features/auth/login/data/model/auth_login_response_model.dart';

class LoginRepo {
  final Dio dio;

  LoginRepo(this.dio);

  Future<Either<Failure, AuthLoginResponseModel>> login({
    required User userToJson,
  }) async {
    try {
      final response = await dio.post(
        ApiConstants.loginEndPoint,
        data: userToJson.toJson(),
      );
      _saveUserToken(value: response.data['data']?['token']);
      _saveUserName(value: response.data['data']?['user']?['name']);
      return Right(AuthLoginResponseModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

void _saveUserToken({required String value}) {
  LocalStorage.saveData(key: KeyConst.token, value: value);
}

void _saveUserName({required String value}) {
  LocalStorage.saveData(key: KeyConst.userName, value: value);
}
