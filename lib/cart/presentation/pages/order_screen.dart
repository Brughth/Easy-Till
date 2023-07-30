import 'package:auto_route/auto_route.dart';
import 'package:easy_till/cart/logic/cubit/cart_cubit.dart';
import 'package:easy_till/shared/widgets/app_button.dart';
import 'package:easy_till/shared/widgets/app_input.dart';
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
                                  if (pm.id == state.selectedPaymentMothod?.id)
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
                                    _collectedAmountControler.text,
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
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Montant a rembourse",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  // TODO handle this
                                  Text(
                                    "00.0",
                                    style: TextStyle(
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
                                    state.selectedPaymentMothod?.name ?? "",
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
                    child: const Text(
                      'Collect',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {},
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
