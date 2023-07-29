import 'package:dio/dio.dart';
import 'package:easy_till/product/data/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductRepository {
  final Dio dio;
  ProductRepository({
    required this.dio,
  });
  Dio sdjchb = Dio();
  Future<List<ProductModel>> getProducts({required int shopId}) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    Response response = await dio.get(
      '/api/shops/$shopId/products',
      options: Options(
        headers: {
          'Authorization': "Bearer $token",
        },
      ),
    );

    var data = response.data;

    List<ProductModel> products = [];
    for (var jsonProduct in data) {
      products.add(ProductModel.fromJson(jsonProduct));
    }
    return products;
  }
}
