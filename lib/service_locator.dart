import 'package:dio/dio.dart';
import 'package:easy_till/auth/data/repositories/auth_repositiry.dart';
import 'package:easy_till/auth/logic/cubit/auth_cubit.dart';
import 'package:easy_till/cart/data/repositories/cart_repository.dart';
import 'package:easy_till/cart/logic/cubit/cart_cubit.dart';
import 'package:easy_till/product/data/product_repository.dart';
import 'package:easy_till/product/logic/cubit/product_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'interceptor.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingletonAsync(
    () => SharedPreferences.getInstance(),
  );

  getIt.registerSingleton<Dio>(
    Dio(
      BaseOptions(
        baseUrl: 'https://www.till-api.ntech-services.com',
        headers: {
          'Accept': 'application/json',
        },
      ),
    )..interceptors.addAll([
        TokenInterceptor(),
      ]),
  );
  getIt.registerSingleton<AuthRepository>(
    AuthRepository(dio: getIt.get<Dio>()),
  );

  getIt.registerSingleton(
    AuthCubit(
      authRepository: getIt.get<AuthRepository>(),
    ),
  );

  getIt.registerSingleton<ProductRepository>(
    ProductRepository(
      dio: getIt.get<Dio>(),
    ),
  );

  getIt.registerSingleton<ProductCubit>(
    ProductCubit(
      productRepository: getIt.get<ProductRepository>(),
    ),
  );
  getIt.registerSingleton<CartRepository>(
    CartRepository(dio: getIt.get<Dio>()),
  );

  getIt.registerSingleton<CartCubit>(
    CartCubit(cartRepository: getIt.get<CartRepository>()),
  );
}
