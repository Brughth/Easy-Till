import 'package:auto_route/auto_route.dart';
import 'package:easy_till/auth/logic/cubit/auth_cubit.dart';
import 'package:easy_till/cart/logic/cubit/cart_cubit.dart';
import 'package:easy_till/product/logic/cubit/product_cubit.dart';
import 'package:easy_till/service_locator.dart';
import 'package:easy_till/shared/routes/router.dart';
import 'package:easy_till/shared/widgets/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../shared/utils/app_colors.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/app_input.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _pwController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _pwController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) async {
          if (state.errorLoginging) {
            AppSnackBar.showError(
              message: "${state.message}",
              context: context,
            );
          }

          if (state.successLonginging) {
            getIt.get<ProductCubit>().getProducts();
            getIt
                .get<CartCubit>()
                .getPaymentMethods(shopId: state.user!.shopId);
            await AppSnackBar.showSuccess(
              message: "Welcome ${state.user?.name}",
              context: context,
            );

            context.router.pushAndPopUntil(
              const ApplicationRoute(),
              predicate: (_) => false,
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: screenWidth <= 380
                          ? screenWidth * .95
                          : (screenWidth > 380 && screenWidth <= 800)
                              ? screenWidth * .6
                              : screenWidth * .4,
                      height: screenHeight * .53,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.secondaryColor,
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Column(
                            children: [
                              Text(
                                "Sign in to your account",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              AppInput(
                                controller: _emailController,
                                hint: "Enter your email",
                                keyboardType: TextInputType.emailAddress,
                                validators: [
                                  FormBuilderValidators.required(
                                    errorText: "Email is required",
                                  ),
                                  FormBuilderValidators.email(
                                    errorText: "Enter valided email adresse",
                                  )
                                ],
                              ),
                              const SizedBox(height: 20),
                              AppInput(
                                controller: _pwController,
                                hint: "Enter your password",
                                keyboardType: TextInputType.visiblePassword,
                                validators: [
                                  FormBuilderValidators.required(
                                    errorText: "Password is required",
                                  ),
                                ],
                              ),
                            ],
                          ),
                          AppButton(
                            loadingColor: AppColors.whiteGrey,
                            bgColor: AppColors.primaryColor,
                            loading: state.isLonginging,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthCubit>().login(
                                      email: _emailController.text,
                                      password: _pwController.text.trim(),
                                    );
                              }
                            },
                            child: const Text(
                              "Sign In",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
