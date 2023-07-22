import 'package:dio/dio.dart';
import 'package:easy_till/auth/data/repositories/auth_repositiry.dart';
import 'package:easy_till/auth/logic/cubit/auth_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingletonAsync(
    () => SharedPreferences.getInstance(),
  );

  getIt.registerSingleton<Dio>(
    Dio(
      BaseOptions(
        baseUrl: 'https://www.till-api.ntech-services.com',
      ),
    ),
  );
  getIt.registerSingleton<AuthRepository>(
    AuthRepository(dio: getIt.get<Dio>()),
  );

  getIt.registerSingleton(
    AuthCubit(
      authRepository: getIt.get<AuthRepository>(),
    ),
  );
}
