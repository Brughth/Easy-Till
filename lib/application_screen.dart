import 'package:auto_route/auto_route.dart';
import 'package:easy_till/cart/logic/cubit/cart_cubit.dart';
import 'package:easy_till/product/logic/cubit/product_cubit.dart';
import 'package:easy_till/service_locator.dart';
import 'package:easy_till/shared/routes/router.dart';
import 'package:easy_till/shared/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:badges/badges.dart' as badges;

@RoutePage()
class ApplicationScreen extends StatelessWidget {
  const ApplicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(),
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        title: const Text("Easy Till"),
        centerTitle: true,
        actions: [
          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              return badges.Badge(
                badgeContent: Text(state.productsInCart.length.toString()),
                child: IconButton(
                  onPressed: () {
                    context.router.push(const CartRoute());
                  },
                  icon: const Icon(
                    Icons.shopping_cart,
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        bloc: getIt.get<ProductCubit>(),
        builder: (context, state) {
          if (state.isLoadingProduct) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }

          if (state.errorLoadingProduct) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      getIt.get<ProductCubit>().getProducts();
                    },
                    icon: const Icon(
                      Icons.refresh,
                      size: 50,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text("${state.message}"),
                ],
              ),
            );
          }

          if (state.products?.isEmpty ?? true) {
            return const Center(
              child: Text("Aucun produits"),
            );
          }

          var products = state.products!;

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: RefreshIndicator(
              onRefresh: () async {
                getIt.get<ProductCubit>().getProducts();
              },
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 2.2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  var product = products[index];
                  return InkWell(
                    onTap: () {
                      context.read<CartCubit>().addToCart(product);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.white54,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(product.name),
                            Text(
                              product.unitPrice.toString(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: products.length,
              ),
            ),
          );
        },
      ),
    );
  }
}
