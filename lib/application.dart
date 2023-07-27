import 'package:easy_till/cart/logic/cubit/cart_cubit.dart';
import 'package:easy_till/product/logic/cubit/product_cubit.dart';
import 'package:easy_till/service_locator.dart';
import 'package:easy_till/shared/routes/router.dart';
import 'package:easy_till/shared/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth/logic/cubit/auth_cubit.dart';

class Application extends StatelessWidget {
  Application({super.key});
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => getIt.get<AuthCubit>()..checkAuthState(),
        ),
        BlocProvider<ProductCubit>(
          create: (context) => getIt.get<ProductCubit>(),
        ),
        BlocProvider<CartCubit>(
          create: (context) => getIt.get<CartCubit>(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: _appRouter.config(),
        debugShowCheckedModeBanner: false,
        title: 'Easy Till',
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primaryColor,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: AppColors.bgColor,
          textTheme: const TextTheme(),
        ),
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: AppColors.bgColor,
        ),
      ),
    );
  }
}
