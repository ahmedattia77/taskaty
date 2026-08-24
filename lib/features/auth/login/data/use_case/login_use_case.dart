import 'package:dartz/dartz.dart';
import 'package:taskaty/core/errors/failure.dart';
import 'package:taskaty/features/auth/login/data/model/auth_login_response_model.dart';
import 'package:taskaty/features/auth/login/data/repo/login_repo.dart';

class LoginUseCase {
  final LoginRepo loginRepo;

  LoginUseCase(this.loginRepo);

  Future<Either<Failure, AuthLoginResponseModel>> call({
    required User userToJson,
  }) async {
    return await loginRepo.login(userToJson: userToJson);
  }
}
