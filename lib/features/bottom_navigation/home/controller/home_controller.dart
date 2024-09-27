
import 'package:blizerpay/features/bottom_navigation/home/repository/home_repository.dart';
import 'package:flutter/foundation.dart';

class HomeController with ChangeNotifier {
  final homeController = HomeRepository();
  Map<String, dynamic> personalDetails = {};
  bool homeIsLoading = true;
  Future<void> getPersonalDetails() async {
    homeIsLoading = true;
    var response = await homeController.getPersonalDetailes();

    if (!response.containsKey("error")) {
      personalDetails = response;
      homeIsLoading = false;
    }else{
    personalDetails={};
  }
    homeIsLoading = false;
    notifyListeners();
  }
}
