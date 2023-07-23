import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenInterceptor extends QueuedInterceptor {
  String? accessToken;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString('token');

    log("Current token $accessToken", name: "TokenInterceptor+onRequest");

    if (accessToken != null) {
      options.headers["Authorization"] = "Bearer $accessToken";
    }

    return handler.next(options);
  }

  // @override
  // void onError(DioError err, ErrorInterceptorHandler handler) async {
  //   if (err.type == DioErrorType.response &&
  //       (err.response?.statusCode == 403 || err.response?.statusCode == 401)) {
  //     var options = err.requestOptions;
  //     try {
  //       var newToken = await getIt.get<AuthRepository>().refreshToken();
  //       var dio = getIt.get<Dio>(instanceName: ktik);

  //       if (newToken != null) {
  //         options.headers["Authorization"] = "Bearer $newToken";
  //         dio.fetch(options).then(
  //           (response) {
  //             return response;
  //           },
  //           onError: (e) {
  //             handler.reject(e);
  //           },
  //         );
  //       }
  //     } catch (e) {
  //       return handler.reject(err);
  //     }

  //     debugPrint(err.response.toString());
  //   }

  //   return handler.next(err);
  // }
}
