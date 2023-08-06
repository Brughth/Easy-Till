import 'package:bloc/bloc.dart';
import 'package:easy_till/cart/data/models/payment_method_model.dart';
import 'package:easy_till/cart/data/repositories/cart_repository.dart';
import 'package:easy_till/product/data/models/product_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository cartRepository;
  CartCubit({
    required this.cartRepository,
  }) : super(
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

  clearCart() {
    emit(
      state.copyWith(
        productsInCart: [],
        total: 0.0,
      ),
    );
  }

  setSelectedPaymentMethod(PaymentMethodModel pm) {
    emit(
      state.copyWith(
        selectedPaymentMethod: pm,
      ),
    );
  }

  getPaymentMethods({required int shopId}) async {
    try {
      emit(
        state.copyWith(
          isLoadingPm: true,
          errorLoadingPm: false,
          successLoadingPm: false,
        ),
      );

      var shopPms = await cartRepository.getPaymentMethods(shopId: shopId);
      emit(
        state.copyWith(
          shopPaymentMethods: shopPms,
          isLoadingPm: false,
          errorLoadingPm: false,
          successLoadingPm: true,
        ),
      );
    } catch (e) {
      print(e);
      emit(
        state.copyWith(
          isLoadingPm: false,
          errorLoadingPm: true,
          successLoadingPm: false,
        ),
      );
    }
  }
}
