part of 'cart_cubit.dart';

class CartState {
  List<ProductModel> productsInCart;
  double total;
  PaymentMethodModel? selectedPaymentMethod;
  //
  List<PaymentMethodModel>? shopPaymentMethods;
  bool isLoadingPm;
  bool errorLoadingPm;
  bool successLoadingPm;
  //
  CartState({
    required this.productsInCart,
    required this.total,
    this.selectedPaymentMethod,
    this.shopPaymentMethods,
    this.isLoadingPm = false,
    this.errorLoadingPm = false,
    this.successLoadingPm = false,
  });

  CartState copyWith({
    List<ProductModel>? productsInCart,
    double? total,
    PaymentMethodModel? selectedPaymentMethod,
    List<PaymentMethodModel>? shopPaymentMethods,
    bool? isLoadingPm,
    bool? errorLoadingPm,
    bool? successLoadingPm,
  }) {
    return CartState(
      productsInCart: productsInCart ?? this.productsInCart,
      total: total ?? this.total,
      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
      shopPaymentMethods: shopPaymentMethods ?? this.shopPaymentMethods,
      isLoadingPm: isLoadingPm ?? this.isLoadingPm,
      errorLoadingPm: errorLoadingPm ?? this.errorLoadingPm,
      successLoadingPm: successLoadingPm ?? this.successLoadingPm,
    );
  }
}
