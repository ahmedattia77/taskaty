import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskaty/core/constants/app_const/key_const.dart';
import 'package:taskaty/core/routing/app_router.dart';
import 'package:taskaty/core/routing/routs.dart';
import 'package:taskaty/core/services/local_storage.dart';
import 'package:taskaty/core/theme/app_theme.dart';
import 'package:taskaty/core/theme/cubit/theme_cubit.dart';

class TaskatyApp extends StatelessWidget {
  const TaskatyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 546),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => BlocProvider(
        create: (context) => ThemeCubit(),
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Taskaty',
              theme: context.read<ThemeCubit>().themeData,
              onGenerateRoute: (settings) =>
                  AppRouter.onGenerateRoute(settings),
              initialRoute: _initRoute(),
              // initialRoute: Routes.welcomeScreenRoute,
            );
          },
        ),
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
