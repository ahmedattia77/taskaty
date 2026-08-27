part of 'theme_cubit.dart';

@immutable
sealed class ThemeState {}

final class ThemeInitial extends ThemeState {}

final class OnChangeState extends ThemeState {
  final ThemeData theme;
  OnChangeState(this.theme);
}
