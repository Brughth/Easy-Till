import 'package:dio/dio.dart';
import 'package:easy_till/product/data/models/product_model.dart';

class ProductRepository {
  final Dio dio;
  ProductRepository({
    required this.dio,
  });
  Future<List<ProductModel>> getProducts({required int shopId}) async {
    Response response = await dio.get(
      '/api/shops/$shopId/products',
    );

    var data = response.data;

    List<ProductModel> products = [];
    for (var jsonProduct in data) {
      products.add(ProductModel.fromJson(jsonProduct));
    }
    return products;
  }
}
