import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:taskaty/core/constants/app_const/key_const.dart';
import 'package:taskaty/core/services/local_storage.dart';
import 'package:taskaty/core/theme/app_theme.dart';
part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial()) {
    _initTheme();
  }

  ThemeData themeData = AppTheme.lightMode;

  void _initTheme() {
    final isDark =
        LocalStorage.getData(key: KeyConst.themeMode) as bool? ?? false;
    themeData = isDark ? AppTheme.darkMode : AppTheme.lightMode;
    emit(OnChangeState(themeData));
  }

  void changeMode() {
    if (themeData == AppTheme.darkMode) {
      themeData = AppTheme.lightMode;
      LocalStorage.saveData(key: KeyConst.themeMode, value: false);
    } else {
      themeData = AppTheme.darkMode;
      LocalStorage.saveData(key: KeyConst.themeMode, value: true);
    }

    emit(OnChangeState(themeData));
  }
}
