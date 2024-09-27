import 'dart:developer';
import 'dart:io';
import 'package:blizerpay/core/dio_helper.dart';
import 'package:blizerpay/core/local_storage.dart';
import 'package:blizerpay/core/utils.dart';
import 'package:dio/dio.dart';

class ProfileRepository {
  Future<Map<String, dynamic>> postImage(File file) async {
    Dio dio = Dio();
    try {
      final token = await LocalStorage().getToken();
      var dataFile =
          await MultipartFile.fromFile(file.path, filename: 'upload.jpg');
      final requestData = FormData.fromMap({
        "profileImage": dataFile,
      });
      final headers = {
        'Content-Type': 'multipart/form-data',
        'Authorization': token,
      };
      final response = await dio.post(
        "https://admin.blizerpay.com/api/user/upload-profile",
        data: requestData,
        options: Options(headers: headers),
      );
      log("Response status code: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Success:${response.data}");
        return response.data;
      } else {
        return Utile.handleErrorResponse(response.statusCode, response.data);
      }
    } catch (e) {
      if (e is DioException) {
        log("Dio error: ${e.response?.statusCode} - ${e.response?.data}");
        return Utile.handleErrorResponse(
            e.response?.statusCode, e.response?.data);
      } else {
        log("Unknown error: $e");
        return {
          "error": "An unexpected error occurred. Please try again later."
        };
      }
    }
  }

  Future<Map<String, dynamic>> deletImageFromServer() async {
    try {
      final dio = await DioHelper.getInstance();
      // final requestData = {"walletNumber": walletNumber, "amount": amount};

      final response = await dio.post(
        "https://admin.blizerpay.com/api/user/deleteProfile",
      );
      log("Response status code: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Success:${response.data}");
        return response.data;
      } else {
        return Utile.handleErrorResponse(response.statusCode, response.data);
      }
    } catch (e) {
      if (e is DioException) {
        log("Dio error: ${e.response?.statusCode} - ${e.response?.data}");
        return Utile.handleErrorResponse(
            e.response?.statusCode, e.response?.data);
      } else {
        log("Unknown error: $e");
        return {
          "error": "An unexpected error occurred. Please try again later."
        };
      }
    }
  }

  Future<Map<String, dynamic>> patcheditProfile(
      String? email, String? name) async {
    final dio = await DioHelper.getInstance();
    final requestData = {"email": email, "name": name};

    final response = await dio.patch(
        "https://admin.blizerpay.com/api/user/editDetails",
        data: requestData);
    log("Success   status code:${response.data}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      log("Success:${response.data}");
      return response.data;
    } else {
      return {"error": "error"};
    }
  }
}
