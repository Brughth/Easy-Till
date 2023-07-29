import 'package:bloc/bloc.dart';
import 'package:easy_till/product/data/models/product_model.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit()
      : super(
          CartState(
            productsInCart: [],
            total: 0.0,
          ),
        );

  updateTotal() {
    double total = 0;
    for (var p in state.productsInCart) {
      total = total + (p.unitPrice * (p.quantity ?? 1));
    }

    emit(
      state.copyWith(
        total: total,
      ),
    );
  }

  getIndex(ProductModel product) {
    return state.productsInCart.indexWhere((item) => item.id == product.id);
  }

  isInCart(ProductModel product) {
    return getIndex(product) >= 0;
  }

  incrementQuantity(ProductModel product) {
    var index = getIndex(product);
    List<ProductModel> products = [...state.productsInCart];
    products[index].quantity = products[index].quantity! + 1;
    emit(
      state.copyWith(
        productsInCart: products,
      ),
    );
    updateTotal();
  }

  decrementQuantity(ProductModel product) {
    List<ProductModel> products = [...state.productsInCart];
    var index = getIndex(product);
    if (product.quantity == 1) {
      products.removeAt(index);
    } else {
      products[index].quantity = products[index].quantity! - 1;
    }
    emit(
      state.copyWith(
        productsInCart: products,
      ),
    );
    updateTotal();
  }

  addToCart(ProductModel product) {
    if (isInCart(product)) {
      incrementQuantity(product);
    } else {
      List<ProductModel> products = [...state.productsInCart];
      products.add(
        product.copyWith(
          quantity: 1,
        ),
      );
      emit(
        state.copyWith(
          productsInCart: products,
        ),
      );
    }
    updateTotal();
  }
}
