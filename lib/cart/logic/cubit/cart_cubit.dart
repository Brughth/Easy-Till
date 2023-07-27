import 'package:bloc/bloc.dart';
import 'package:easy_till/product/data/models/product_model.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit()
      : super(
          CartState(
            productsInCart: [],
          ),
        );

  getIndex(ProductModel product) {
    return state.productsInCart.indexWhere((item) => item.id == product.id);
  }

  isInCart(ProductModel product) {
    return getIndex(product) >= 0;
  }

  addToCart(ProductModel product) {
    if (isInCart(product)) {
      var index = getIndex(product);
      List<ProductModel> products = [...state.productsInCart];
      products[index].quantity = products[index].quantity! + 1;
      emit(
        state.copyWith(
          productsInCart: products,
        ),
      );
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
  }
}
