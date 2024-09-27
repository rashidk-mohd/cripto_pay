import 'dart:developer';

import 'package:blizerpay/core/dio_helper.dart';


class HistoryRepository {
  Future<List<dynamic>> getWalletHistory() async {
    try {
      final dio = await DioHelper.getInstance();
      var response = await dio
          .get("https://admin.blizerpay.com/api/user/getWalletHistory");
      final data=response.data as Map<String, dynamic>;
           log("transactionHistory=====>  $data");

      List<dynamic> transactionHistory =
          data["transactionHistory"] ;
      log("transactionHistory=====>  $transactionHistory");
      return transactionHistory;
    } catch (e) {
      log("================> $e");
      return [
        {"error": "Error Occured"}
      ];
    }
  }
}
