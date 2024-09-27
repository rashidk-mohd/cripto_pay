import 'dart:developer';

import 'package:blizerpay/core/local_storage.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static Future<Dio> getInstance() async {
    String? token = await LocalStorage().getToken();
    log("Fetched Token: $token"); 

    Dio dio = Dio();
    dio.options.headers["Content-Type"] = "application/json";
    // dio.options.headers["Accept"] = "application/json";
    if (token.isNotEmpty) {
      dio.options.headers["Authorization"] = token;
    
    } else {
      log("Token is null or empty. Authorization header will not be set.");
    }

    

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          log("Request URL: ${options.uri}");
          log("Request headers: ${options.headers}"); 
          return handler.next(options);
        },
        onError: (e, handler) {
          log("Error: ${e.response?.data}");
          return handler.next(e);
        },
      ),
    );

    return dio;
  }
}
