import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:taskaty/features/auth/login/data/model/auth_login_response_model.dart';
import 'package:taskaty/features/auth/login/data/use_case/login_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit(this.loginUseCase) : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());

    final userToJson = User(email: email, password: password);

    final response = await loginUseCase.call(userToJson: userToJson);

    response.fold(
      (failer) {
        emit(LoginError(errro: failer.errMessage));
      },
      (response) {
        emit(LoginSuccess(response: response));
      },
    );
  }
}
