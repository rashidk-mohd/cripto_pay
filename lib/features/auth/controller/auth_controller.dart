import 'dart:developer';
import 'package:blizerpay/core/local_storage.dart';
import 'package:blizerpay/features/auth/repository/auth_repository.dart';
import 'package:blizerpay/features/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  AuthenticationRepository authRepository = AuthenticationRepository();
  List<int> verificationValues = [];

  LocalStorage localStorage = LocalStorage();
  Future<void> logOut(BuildContext context) async {
    await localStorage.clearLogInStatus();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SplashScreen()));
  }

  void addValueToListForVerification(int value) {
    log("Current List Length: ${verificationValues.length}");

    if (verificationValues.length < 4) {
      // Add value if the list has less than 4 items
      verificationValues.add(value);
    } else {
      // If the list reaches or exceeds 4, clear it first, then add the new value
      verificationValues.clear();
      verificationValues.add(value);
      log("List cleared, adding new value");
    }

    log("Updated Verification Values: $verificationValues");
    notifyListeners();
  }
}
