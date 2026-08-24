import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskaty/core/constants/app_const/key_const.dart';
import 'package:taskaty/core/routing/app_router.dart';
import 'package:taskaty/core/routing/routs.dart';
import 'package:taskaty/core/services/local_storage.dart';
import 'package:taskaty/core/theme/app_theme.dart';

class TaskatyApp extends StatelessWidget {
  const TaskatyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 546),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Taskaty',
        theme: AppTheme.darkMode,
        onGenerateRoute: (settings) => AppRouter.onGenerateRoute(settings),
        initialRoute: _initRoute(),
      ),
    );
  }

  String _initRoute() {
    if (LocalStorage.getData(key: KeyConst.token) != null) {
      return Routes.homeScreenRoute;
    } else {
      return Routes.loginScreenRoute;
    }
  }
}
