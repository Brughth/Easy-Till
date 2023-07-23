part of 'product_cubit.dart';

@immutable
class ProductState {
  List<ProductModel>? products;
  bool isLoadingProduct;
  bool successLoadingProduct;
  bool errorLoadingProduct;

  String? message;

  ProductState({
    this.products,
    this.isLoadingProduct = false,
    this.successLoadingProduct = false,
    this.errorLoadingProduct = false,
    this.message,
  });

  ProductState copyWith({
    List<ProductModel>? products,
    bool? isLoadingProduct,
    bool? successLoadingProduct,
    bool? errorLoadingProduct,
    String? message,
  }) {
    return ProductState(
      products: products ?? this.products,
      isLoadingProduct: isLoadingProduct ?? this.isLoadingProduct,
      successLoadingProduct:
          successLoadingProduct ?? this.successLoadingProduct,
      errorLoadingProduct: errorLoadingProduct ?? this.errorLoadingProduct,
      message: message ?? this.message,
    );
  }
}
