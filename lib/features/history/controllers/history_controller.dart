import 'package:blizerpay/features/history/repository/history_repository.dart';
import 'package:flutter/material.dart';

class HistorController with ChangeNotifier {
  HistoryRepository reo = HistoryRepository();
  List history = [];
  bool isLoading = true;
  Future getWalletHistory() async {
    isLoading = true;
    final response = await reo.getWalletHistory();
    if (response.isNotEmpty) {
      history = response;
    }
    isLoading = false;
    notifyListeners();
  }
}
