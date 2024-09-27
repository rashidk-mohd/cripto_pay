import 'dart:developer';
import 'package:blizerpay/core/dio_helper.dart';
import 'package:blizerpay/core/utils.dart';
import 'package:dio/dio.dart';

class AuthenticationRepository {
  Dio dio = Dio();
  Future<Map<String, dynamic>> registerUser(
      String? name, String? email, String? password) async {
    final requestData = {
      "name": name,
      "email": email,
      "password": password,
    };
    try {
      final response = await dio.post(
          "https://admin.blizerpay.com/api/user/register",
          data: requestData);
      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Suc cess:${response.statusCode}");
        return response.data;
      } else if (response.statusCode == 409) {
        return {"error": "user already exits with this same mail id "};
      } else {
        return Utile.handleRegistrationErrorResponse(
            response.statusCode, response.data);
      }
    } catch (e) {
      if (e is DioException) {
        if (e.error == "user already exits with this same mail id") {
          return {"error": "user already exits with this same mail id"};
        } else {
          log("Dio error: ${e.response?.statusCode} - ${e.response?.data}");
          if(e.response?.statusCode==409){
            return {"error":"user already exist with this same mail id"};
          }else{
return Utile.handleErrorResponse(
              e.response?.statusCode, e.response?.data);
          }
          
        }
      } else {
        log("Unknown error: $e");
        return {
          "error": "An unexpected error occurred. Please try again later."
        };
      }
    }
  }

  Future<Map<String, dynamic>> verification(
    String? otp,
  ) async {
    final requestData = {"otp": otp};
    log("data==>:$requestData");
    try {
      final dio = await DioHelper.getInstance();
      final response = await dio.post(
          "https://admin.blizerpay.com/api/user/verification",
          data: requestData);
      log("data==>:${response.data}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Success:${response.data}");
        return response.data;
      } else {
        return Utile.handleVerificatioErrorResponse(
            response.statusCode, response.data);
      }
    } catch (e) {
      if (e is DioException) {
        log("Dio error: ${e.response?.statusCode} - ${e.response?.data}");
        return Utile.handleVerificatioErrorResponse(
            e.response?.statusCode, e.response?.data);
      } else {
        log("Unknown error: $e");
        return {
          "error": "An unexpected error occurred. Please try again later."
        };
      }
    }
  }

  Future<Map<String, dynamic>> signIn(String? email, String? password) async {
    try {
      Dio dio = Dio();
      final requestData = {
        "email": email,
        "password": password,
      };

      final response = await dio.post(
          "https://admin.blizerpay.com/api/user/login",
          data: requestData);
      log("Response status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        log("Success:${response.data}");
        return response.data;
      } else {
        return Utile.handleSignInErrorResponse(
            response.statusCode, response.data);
      }
    } catch (e) {
      if (e is DioException) {
        log("Dio error: ${e.response?.statusCode} - ${e.response?.data}");
        return Utile.handleSignInErrorResponse(
            e.response?.statusCode, e.response?.data);
      } else {
        log("Unknown error: $e");
        return {
          "error": "An unexpected error occurred. Please try again later."
        };
      }
    }
  }

  Future<Map<String, dynamic>> sendOtpTomail(String? email) async {
    print("Response starts");
    try {
      final dio = await DioHelper.getInstance();
      final requestData = {
        "email": email,
      };

      final response = await dio.post(
          "https://admin.blizerpay.com/api/user/forgot-password-sendOtp",
          data: requestData);
      log("Response status code: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Success:${response.data}");
        return response.data;
      } else {
        print("nbnfg");
        return Utile.handleSendOtpErrorResponse(
            response.statusCode, response.data);
      }
    } catch (e) {
      log("error from catch => $e");
      if (e is DioException) {
        log("Dio error: ${e.response?.statusCode} - ${e.response?.data}");
        return {"error": "User not exist"};
      } else {
        log("Unknown error: $e");
        return {
          "error": "An unexpected error occurred. Please try again later."
        };
      }
    }
  }

  Future<Map<String, dynamic>> verifiForgotMail(String? otp) async {
    try {
      final dio = await DioHelper.getInstance();
      final requestData = {
        "otp": otp,
      };

      final response = await dio.post(
          "https://admin.blizerpay.com/api/user/verify-otp",
          data: requestData);
      log("Response status code: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Success:${response.data}");
        return response.data;
      } else {
        return Utile.handleVerificationForgotPasswordErrorResponse(
            response.statusCode, response.data);
      }
    } catch (e) {
      if (e is DioException) {
        log("Dio error: ${e.response?.statusCode} - ${e.response?.data}");
        return Utile.handleVerificationForgotPasswordErrorResponse(
            e.response?.statusCode, e.response?.data);
      } else {
        log("Unknown error: $e");
        return {
          "error": "An unexpected error occurred. Please try again later."
        };
      }
    }
  }

  Future<Map<String, dynamic>> updatePassword(
      {String? userId, String? password}) async {
    try {
      // final dio = await DioHelper.getInstance();
      final requestData = {"userId": userId, "password": password};

      final response = await dio.patch(
          "https://admin.blizerpay.com/api/user/change-password",
          data: requestData);
      log("Response status code: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Success:${response.data}");
        return response.data;
      } else {
        return Utile.handleUpdatPasswordErrorResponse(
            response.statusCode, response.data);
      }
    } catch (e) {
      if (e is DioException) {
        log("Dio error: ${e.response?.statusCode} - ${e.response?.data}");
        return Utile.handleUpdatPasswordErrorResponse(
            e.response?.statusCode, e.response?.data);
      } else {
        log("Unknown error: $e");
        return {
          "error": "An unexpected error occurred. Please try again later."
        };
      }
    }
  }
}
