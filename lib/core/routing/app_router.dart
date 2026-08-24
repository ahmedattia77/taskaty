import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskaty/core/routing/routs.dart';
import 'package:taskaty/core/services/service_locator.dart';
import 'package:taskaty/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:taskaty/features/auth/login/presentation/ui/pages/login_screen.dart';
import 'package:taskaty/features/home/presentation/ui/pages/home_screen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginScreenRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: LoginScreen(),
          ),
        );

      case Routes.homeScreenRoute:
        return MaterialPageRoute(builder: (context) => HomeScreen());

      default:
        return MaterialPageRoute(builder: (context) => LoginScreen());
    }
  }
}
