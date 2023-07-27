part of 'cart_cubit.dart';

class CartState {
  List<ProductModel> productsInCart;
  CartState({
    required this.productsInCart,
  });

  CartState copyWith({
    List<ProductModel>? productsInCart,
  }) {
    return CartState(
      productsInCart: productsInCart ?? this.productsInCart,
    );
  }
}
