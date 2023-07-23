import 'package:bloc/bloc.dart';
import 'package:easy_till/auth/logic/cubit/auth_cubit.dart';
import 'package:easy_till/product/data/models/product_model.dart';
import 'package:easy_till/product/data/product_repository.dart';
import 'package:easy_till/service_locator.dart';
import 'package:easy_till/shared/utils/utils.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository productRepository;
  ProductCubit({
    required this.productRepository,
  }) : super(
          ProductState(),
        );

  getProducts() async {
    emit(
      state.copyWith(
        isLoadingProduct: true,
        successLoadingProduct: false,
        errorLoadingProduct: false,
      ),
    );

    try {
      var user = getIt.get<AuthCubit>().state.user;

      var products = await productRepository.getProducts(
        shopId: user!.shopId,
      );

      emit(
        state.copyWith(
          products: products,
          isLoadingProduct: false,
          successLoadingProduct: true,
          errorLoadingProduct: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingProduct: false,
          successLoadingProduct: false,
          errorLoadingProduct: true,
          message: Utils.extracMessage(e),
        ),
      );
    }
  }
}
