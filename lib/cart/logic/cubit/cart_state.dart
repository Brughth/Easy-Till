part of 'cart_cubit.dart';

class CartState {
  List<ProductModel> productsInCart;
  double total;
  CartState({
    required this.productsInCart,
    required this.total,
  });

  CartState copyWith({
    List<ProductModel>? productsInCart,
    double? total,
  }) {
    return CartState(
      productsInCart: productsInCart ?? this.productsInCart,
      total: total ?? this.total,
    );
  }
}
