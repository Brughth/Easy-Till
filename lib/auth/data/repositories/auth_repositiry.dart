import 'package:dio/dio.dart';
import 'package:easy_till/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final Dio dio;

  AuthRepository({
    required this.dio,
  });

  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    Response response = await dio.post(
      '/api/auth/login',
      data: {
        "email": email,
        "password": password,
      },
    );

    var data = response.data;
    var token = data['token'];

    if (token != null) {
      var prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
    }

    return UserModel.fromJson(data['user']);
  }

  Future<UserModel> getUser() async {
    Response response = await dio.get('/api/auth/me');
    return UserModel.fromJson(response.data);
  }
}
