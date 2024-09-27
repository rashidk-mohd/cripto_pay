import 'dart:developer';

import 'package:blizerpay/features/bottom_navigation/home/repository/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WalletToWalletNotifier extends StateNotifier<bool> {
  final HomeRepository homeRepository;
  String? error;
  WalletToWalletNotifier(this.homeRepository) : super(false);
  Future<Map<String,dynamic>> walletTowalltTransfer(String? walletNumber, double? amount,
      BuildContext context, String? msg) async {
    state = true;
    final response =
        await homeRepository.postWalletToWalletTransfer(walletNumber, amount);
    log(response.toString());
    if (!response.containsKey("error")) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("successfully transfered"),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
      state = false;
      return response;
    } else if (response["error"] == "insufficiant balance") {
      state = false;
      return {"msg":"Insufficient balance"};
      
    } else {
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response["error"]),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
       state = false;
      return {"error":response["error"]};
    }
   
  }
}
