import 'dart:developer';
import 'package:blizerpay/core/local_storage.dart';
import 'package:blizerpay/core/utils.dart';
import 'package:blizerpay/features/auth/repository/auth_repository.dart';
import 'package:blizerpay/features/auth/screens/sign_in_screen.dart';
import 'package:blizerpay/features/auth/screens/verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpNotifiear extends StateNotifier<bool> {
  final AuthenticationRepository authRepository;
  SignUpNotifiear(this.authRepository) : super(false);
  Future<void> signUp(String? name, String? email, String? password,
      BuildContext context) async {
    state = true;
    var response = await authRepository.registerUser(name, email, password);
    if (!response.containsKey("error")) {
      if (response["statusCode"] == 200 || response["statusCode"] == 201) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>  VerificationScreen(isFromForgot: false,email: email,),
        ));
      }
    } else {
     Utile.showSnackBarI(context, response["error"], false);

    }

    state = false;
  }
}

class SignUpVerificationNotifier extends StateNotifier<bool> {
  final AuthenticationRepository authenticationRepository;
  SignUpVerificationNotifier(this.authenticationRepository) : super(false);
  Future<void> verifSignUpyOtp(BuildContext context, {required String? otp}) async {
    var response = await authenticationRepository.verification(otp);
    log("statusCode--- ${response["statusCode"]}");
    if (response["statusCode"] == 200 || response["statusCode"] == 201) {
      await LocalStorage().setLogInStatus(true);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ));
    } else {
      // ignore: use_build_context_synchronously
      Utile.showSnackBarI(context, response["error"], false);
    }
  }
}
