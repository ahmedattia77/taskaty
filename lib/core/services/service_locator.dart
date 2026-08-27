import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:taskaty/core/constants/app_const/key_const.dart';
import 'package:taskaty/core/constants/networking/api_constants.dart';
import 'package:taskaty/core/services/internet_connection/cubit/network_status_cubit.dart';
import 'package:taskaty/core/services/local_storage.dart';
import 'package:taskaty/features/auth/login/data/repo/login_repo.dart';
import 'package:taskaty/features/auth/login/data/use_case/login_use_case.dart';
import 'package:taskaty/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:taskaty/features/home/data/repo/get_tasks_repo.dart';
import 'package:taskaty/features/home/data/use_case/get_tasks_use_case.dart';
import 'package:taskaty/features/home/presentation/cubit/home_cubit.dart';

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

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final publicEndpoints = [
            ApiConstants.loginEndPoint,
            ApiConstants.resgisterEndPoint,
          ];

          final isPublic = publicEndpoints.any(
            (path) => options.path.contains(path),
          );

          if (!isPublic) {
            final token = LocalStorage.getData(key: KeyConst.token);
            if (token != null && token.toString().isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          }
          return handler.next(options);
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

  // provide the login repo and use case to the cubit,
  getIt.registerLazySingleton<GetTaskRepo>(() => GetTaskRepo(getIt<Dio>()));

  getIt.registerLazySingleton<GetTasksUseCase>(
    () => GetTasksUseCase(getIt<GetTaskRepo>()),
  );

  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt<LoginUseCase>()));
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt<GetTasksUseCase>()));

  getIt.registerFactory<NetworkStatusCubit>(() => NetworkStatusCubit());
}
