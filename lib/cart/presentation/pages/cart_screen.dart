import 'package:auto_route/auto_route.dart';
import 'package:easy_till/cart/logic/cubit/cart_cubit.dart';
import 'package:easy_till/product/data/models/product_model.dart';
import 'package:easy_till/shared/routes/router.dart';
import 'package:easy_till/shared/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/utils/app_colors.dart';

@RoutePage()
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        title: const Text("Cart"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(
                      scrollbars: false,
                    ),
                    child: ListView.separated(
                      itemCount: state.productsInCart.length,
                      itemBuilder: (context, index) {
                        ProductModel product = state.productsInCart[index];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  //Image.asset("assets/images/profile_pic.png"),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(product.name),
                                      const SizedBox(height: 5),
                                      Text(
                                        "${product.unitPrice}",
                                        textAlign: TextAlign.end,
                                        style: const TextStyle(
                                          color: AppColors.whiteGrey,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        context
                                            .read<CartCubit>()
                                            .decrementQuantity(product);
                                      },
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: product.quantity == 1
                                              ? AppColors.errorColor
                                              : null,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border:
                                              Border.all(color: Colors.white10),
                                        ),
                                        child: Icon(
                                          product.quantity == 1
                                              ? Icons.close
                                              : Icons.remove,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Text(
                                        "${product.quantity}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        context
                                            .read<CartCubit>()
                                            .incrementQuantity(product);
                                      },
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white10),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: const Icon(Icons.add),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "${product.unitPrice * product.quantity!}",
                                textAlign: TextAlign.end,
                              ),
                            )
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(height: 35);
                      },
                    ),
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${state.total.ceil()}",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            borderColor: AppColors.grayScale,
                            onPressed: () {
                              context.read<CartCubit>().clearCart();
                            },
                            child: const Text(
                              'Clear Cart',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 30),
                        Expanded(
                          child: AppButton(
                            bgColor: AppColors.primaryColor,
                            onPressed: () {
                              context.router.push(const OrderRoute());
                            },
                            child: const Text(
                              'Order',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
