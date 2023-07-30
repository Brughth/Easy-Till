import 'package:dio/dio.dart';
import 'package:easy_till/cart/data/models/payment_method_model.dart';

class CartRepository {
  final Dio dio;
  CartRepository({
    required this.dio,
  });

  Future<List<PaymentMethodModel>> getPaymentMethods(
      {required int shopId}) async {
    Response response = await dio.get(
      '/api/shops/$shopId/payment-methods',
    );

    var data = <PaymentMethodModel>[];

    for (var item in response.data) {
      data.add(PaymentMethodModel.fromJson(item));
    }

    return data;
  }
}
