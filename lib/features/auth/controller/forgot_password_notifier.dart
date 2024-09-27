import 'dart:developer';
import 'package:blizerpay/core/local_storage.dart';
import 'package:blizerpay/core/utils.dart';
import 'package:blizerpay/features/auth/repository/auth_repository.dart';
import 'package:blizerpay/features/auth/screens/forgot_password_screen.dart';
import 'package:blizerpay/features/auth/screens/sign_in_screen.dart';
import 'package:blizerpay/features/auth/screens/verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SendOtpToMailNotifier extends StateNotifier<bool> {
  final AuthenticationRepository authenticationRepository;
  SendOtpToMailNotifier(this.authenticationRepository) : super(false);
  Future<void> sendOtpTomail(String? email, BuildContext context) async {
    print("email=======>>  $email");
    state = true;
    final response = await authenticationRepository.sendOtpTomail(email);
    print("response send otp==> $response");
    print("response send otp==> ${response.containsKey("error")}");
    await LocalStorage().setUserID(response["data"]["userId"]);
    if (!response.containsKey("error")) {
      Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => VerificationScreen(
              isFromForgot: true,
              email: email,
            ),
          ));
      state = false;
    } else {
      state = false;
      log('state=========================> $state');
      Navigator.pop(context);
      Utile.showSnackBarI(context, response["error"], false);

      state = false;
    }

    state = false;
  }
}

class VerifyForgotPasswordNotifier extends StateNotifier<bool> {
  final AuthenticationRepository authenticationRepository;
  VerifyForgotPasswordNotifier(this.authenticationRepository) : super(false);
  Future<void> verifyForgotPassword(String? otp, BuildContext context) async {
    state = true;
    final response = await authenticationRepository.verifiForgotMail(otp);
    if (!response.containsKey("error")) {
      Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => const ForgotPasswordScreen(),
          ));
      state = false;
    } else {
      Utile.showSnackBarI(context, response["error"], false);
      state = false;
    }

    state = false;
  }
}

class UpdatePasswordNotifier extends StateNotifier<bool> {
  final AuthenticationRepository authenticationRepository;
  UpdatePasswordNotifier(this.authenticationRepository) : super(false);
  Future updatePassword(BuildContext context, {String? password}) async {
    final userId = await LocalStorage().getUserID();
    print("userId===> $userId");
    state = true;
    final response = await authenticationRepository.updatePassword(
        password: password, userId: userId);
    if (!response.containsKey("error")) {
      Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => const SignInScreen(),
          ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response["error"]),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
      state = false;
    }

    state = false;
  }
}
