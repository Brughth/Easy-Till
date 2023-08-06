import 'package:auto_route/auto_route.dart';
import 'package:easy_till/auth/logic/cubit/auth_cubit.dart';
import 'package:easy_till/cart/data/repositories/cart_repository.dart';
import 'package:easy_till/cart/logic/cubit/cart_cubit.dart';
import 'package:easy_till/service_locator.dart';
import 'package:easy_till/shared/utils/utils.dart';
import 'package:easy_till/shared/widgets/app_button.dart';
import 'package:easy_till/shared/widgets/app_input.dart';
import 'package:easy_till/shared/widgets/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/utils/app_colors.dart';

@RoutePage()
class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late TextEditingController _nameController;
  late TextEditingController _collectedAmountControler;
  double collectedAmount = 0;
  double toReimbursed = 0;
  bool isLoading = false;
  var total = getIt.get<CartCubit>().state.total;

  @override
  void initState() {
    _nameController = TextEditingController();
    _collectedAmountControler = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        title: const Text("Order"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppInput(
                    controller: _nameController,
                    label: "Customer Name",
                    hint: "Enter customer name",
                    labelStyle: const TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 20),
                  AppInput(
                    controller: _collectedAmountControler,
                    label: "Colected Amount",
                    keyboardType: TextInputType.number,
                    hint: "Enter colected amount",
                    onChange: (value) {
                      setState(() {
                        collectedAmount = double.parse(value);
                        toReimbursed = collectedAmount - total;
                      });
                    },
                    labelStyle: const TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Select Payment Method",
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    children: (state.shopPaymentMethods ?? [])
                        .map(
                          (pm) => Padding(
                            padding: const EdgeInsets.only(
                              right: 20,
                              bottom: 8,
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(4),
                              onTap: () {
                                context
                                    .read<CartCubit>()
                                    .setSelectedPaymentMethod(pm);
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: 100,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Colors.white54,
                                      ),
                                    ),
                                    child: Center(child: Text(pm.name)),
                                  ),
                                  if (pm.id == state.selectedPaymentMethod?.id)
                                    const Positioned(
                                      right: 0,
                                      child: Icon(
                                        Icons.check_box,
                                        color: AppColors.successColor,
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 30),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.primaryText,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Total receivable",
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
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Container(
                                height: 1,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.primaryText,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Received amount",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${collectedAmount.ceil()}",
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Container(
                                height: 1,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.primaryText,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "To be reimbursed",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${toReimbursed.ceil()}",
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Container(
                                height: 1,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.primaryText,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Payment method",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  // TODO handle this
                                  Text(
                                    state.selectedPaymentMethod?.name ?? "",
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  AppButton(
                    bgColor: AppColors.primaryColor,
                    loading: isLoading,
                    child: const Text(
                      'Collect',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () async {
                      if (state.selectedPaymentMethod == null) {
                        AppSnackBar.showError(
                          message: "payment method is required",
                          context: context,
                        );
                        return;
                      }

                      if (_nameController.text.isEmpty) {
                        AppSnackBar.showError(
                          message: "Customer name is required",
                          context: context,
                        );
                        return;
                      }

                      var data = {
                        "till_session_id": 6,
                        "customer_name": _nameController.text,
                        "payment_method_id": state.selectedPaymentMethod!.id,
                        "invoice_lines": state.productsInCart.map((item) {
                          return {
                            "product_id": item.id,
                            "product_name": item.name,
                            "price": item.unitPrice,
                            "product_qty": item.quantity,
                          };
                        }).toList()
                      };

                      setState(() {
                        isLoading = true;
                      });

                      try {
                        var shopId = getIt.get<AuthCubit>().state.user!.shopId;
                        var invoice =
                            await getIt.get<CartRepository>().createInvoice(
                                  data: data,
                                  shopId: shopId,
                                );
                        setState(() {
                          isLoading = false;
                        });
                        AppSnackBar.showSuccess(
                          message: "Success",
                          context: context,
                        );
                      } catch (e) {
                        setState(() {
                          isLoading = false;
                        });
                        print(e);
                        AppSnackBar.showError(
                          message: Utils.extracMessage(e),
                          context: context,
                        );
                      }
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
