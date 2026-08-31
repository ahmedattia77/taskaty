part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeTaskInitial extends HomeState {}

final class HomeTaskLoading extends HomeState {}

final class HomeTaskSuccess extends HomeState {
  final TaskResponseModel taskResponseModel;
  HomeTaskSuccess(this.taskResponseModel);
}

final class HomeTaskFialer extends HomeState {
  final String errorMassage;

  HomeTaskFialer(this.errorMassage);
}
