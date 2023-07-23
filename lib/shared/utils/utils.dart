import 'package:dio/dio.dart';

class Utils {
  static String extracMessage(dynamic e) {
    try {
      if (e is DioException) {
        if (e.response?.data is String) {
          return e.response!.data;
        }
        var data = e.response?.data;

        var error = data['error'];

        if (error is String) {
          return error;
        }
      }
    } catch (e) {
      print(e);
      return e.toString();
    }
    return e.toString();
  }
}
