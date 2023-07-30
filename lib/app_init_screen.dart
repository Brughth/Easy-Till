import 'package:auto_route/auto_route.dart';
import 'package:easy_till/auth/logic/cubit/auth_cubit.dart';
import 'package:easy_till/product/logic/cubit/product_cubit.dart';
import 'package:easy_till/service_locator.dart';
import 'package:easy_till/shared/routes/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart/logic/cubit/cart_cubit.dart';

@RoutePage()
class AppInitScreen extends StatelessWidget {
  const AppInitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.errorCheckingAuthState) {
            context.router.pushAndPopUntil(
              const LoginRoute(),
              predicate: (_) => false,
            );
          }

          if (state.successCheckingAuthState) {
            getIt.get<ProductCubit>().getProducts();
            getIt
                .get<CartCubit>()
                .getPaymentMethods(shopId: state.user!.shopId);
            context.router.pushAndPopUntil(
              const ApplicationRoute(),
              predicate: (_) => false,
            );
          }
        },
        child: const Center(
          child: CupertinoActivityIndicator(
            radius: 80,
          ),
        ),
      ),
    );
  }
}
