part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final AuthLoginResponseModel response;

  LoginSuccess({required this.response});
}

final class LoginError extends LoginState {
  final String errro;
  LoginError({required this.errro});
}
