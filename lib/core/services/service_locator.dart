import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:taskaty/core/constants/networking/api_constants.dart';
import 'package:taskaty/features/auth/login/data/repo/login_repo.dart';
import 'package:taskaty/features/auth/login/data/use_case/login_use_case.dart';
import 'package:taskaty/features/auth/login/presentation/cubit/login_cubit.dart';

final getIt = GetIt.instance;
// one shared instance of Dio, LoginRepo
//, LoginUseCase, and LoginCubit will be created and used
// throughout the app
//with lazy singleton, the instance will be created only when it is first requested
void setupServiceLocator() {
  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        headers: {'Accept': 'application/json'},
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
      ),
    );
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
        filter: (options, args) {
          if (options.path.contains('/posts')) {
            return false;
          }
          return !args.isResponse || !args.hasUint8ListData;
        },
      ),
    );
    return dio;
  });

  // provide the login repo and use case to the cubit,
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt<Dio>()));

  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(getIt<LoginRepo>()),
  );
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt<LoginUseCase>()));
}
