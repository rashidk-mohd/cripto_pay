import 'dart:developer';
import 'package:blizerpay/core/local_storage.dart';
import 'package:blizerpay/core/utils.dart';
import 'package:blizerpay/features/auth/repository/auth_repository.dart';
import 'package:blizerpay/features/bottom_navigation/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInNotifier extends StateNotifier<bool> {
  final AuthenticationRepository authRepository;
  SignInNotifier(this.authRepository) : super(false);
  Future<void> login(
      String? email, String? password, BuildContext context) async {
    state = true;
    await signInData(email, password, authRepository, context);
    state = false;
  }

  Future<void> signInData(String? email, String? password,
      AuthenticationRepository authRepository, BuildContext context) async {
    final response = await authRepository.signIn(email, password);
    log("tokenDatt ------------- ==> $response");
    if (!response.containsKey("error")) {
      await LocalStorage().setToken("Bearer ${response["data"]["token"]}");
      String? token = await LocalStorage().getToken();
     

      
      if (token != "") {
        await LocalStorage().setLogInStatus(true);
        // await LocalStorage().setUserName(response["data"]["data"]["User"]);
       
        await LocalStorage()
            .setReferalCode(response["data"]["data"]["referalCode"]);
        await LocalStorage().setUserID(response["data"]["data"]["_id"]);
        await LocalStorage().setWalletNumber(response["data"]["data"]["walletNumber"]);
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ));
      }
    } else {
      // // ignore: use_build_context_synchronously
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text(response["error"]),
      //     backgroundColor: Colors.red,
      //     duration: const Duration(seconds: 3),
      //   ),
      // );
      Utile.showSnackBarI(context, response["error"], false);
    }
  }
}
