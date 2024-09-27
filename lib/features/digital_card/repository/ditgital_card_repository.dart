import 'dart:developer';
import 'package:blizerpay/core/dio_helper.dart';
import 'package:blizerpay/core/utils.dart';
import 'package:dio/dio.dart';

class DigitalCardRepository {
  Future<Map<String, dynamic>> postPayment(
      int quntity, int price, context) async {
    try {
      final dio = await DioHelper.getInstance();

      final request = {"quantity": quntity, "token": price};

      final response = await dio.post(
        "https://admin.blizerpay.com/api/user/puchase-card",
        data: request,
      );
      log("status code ${response.data}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else if (response.statusCode == 402) {
        return {"error": "Insufficient balance"};
      } else {
        return {"error": "error"};
      }
    } catch (e) {
      if (e is DioException) {
      
          log("Dio error: ${e.response?.statusCode} - ${e.response?.data}");
          if (e.response?.statusCode == 402) {
            return {"error": "Insufficient balance"};
          } else {
            return Utile.handleErrorResponse(
                e.response?.statusCode, e.response?.data);
          
        }
      }else{
        return {"error":"Unexpected Error"};
      }
    }
  }
}
