import 'dart:developer';
import 'package:blizerpay/core/dio_helper.dart';
import 'package:blizerpay/core/utils.dart';
import 'package:dio/dio.dart';

class HomeRepository {
  Future<Map<String, dynamic>> postWalletToWalletTransfer(
      String? walletNumber, double? amount) async {
    log("walletNumber $walletNumber");
    log("walletNumber $amount");
    try {
      final dio = await DioHelper.getInstance();
      final requestData = {"walletNumber": walletNumber, "amount": amount};

      final response = await dio.post(
          "https://admin.blizerpay.com/api/user/walletToWallet",
          data: requestData);
      log("Response status code: ${response}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Success:${response.data}");
        return response.data;
      } else if (response.statusCode == 400) {
        return {"error": response.statusMessage};
      } else {
        return Utile.handleErrorResponse(response.statusCode, response.data);
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response!.statusCode == 401) {
          return {"error": "insufficiant balance"};
        }else if(e.response!.statusCode == 400){
          return {"error": "Cannot send to your own nuber"};
        } else if (e.response!.statusCode == 402) {
          return {"error": "Invalid number"};
        } else {
          log("Dio error: ${e.response?.statusCode} - ${e.response?.data}");
          return Utile.handleErrorResponse(
              e.response?.statusCode, e.response?.data);
        }
      } else {
        log("Unknown error: $e");
        return {
          "error": "An unexpected error occurred. Please try again later."
        };
      }
    }
  }

  Future<Map<String, dynamic>> getPersonalDetailes() async {
    try {
      final dio = await DioHelper.getInstance();
      // dio.options.headers["Authorization"] = await LocalStorage().getToken();
      // dio.options.headers["Accept"] = "application/json";

      var response =
          await dio.get("https://admin.blizerpay.com/api/user/get-user-by-id");
      log("data == ${response.data}");

      return response.data;
    } catch (e) {
      return {"error": "Error Occurred"};
    }
  }
}
