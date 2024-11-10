
import 'package:blizerpay/core/utils.dart';
import 'package:blizerpay/features/bottom_navigation/home/screens/home_screen.dart';
import 'package:blizerpay/features/profile.dart/repository/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileEditNotifier extends StateNotifier<bool> {
  final ProfileRepository repo;
  ProfileEditNotifier(this.repo) : super(false);
  Future<void> editProfile(String? email, String? name, context) async {
    state = true;
    final response = await repo.patcheditProfile(email, name);
    if (!response.containsKey("error")) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ));
      Utile.showSnackBarI(context, "Edited successfully", true);
    } else {
      Utile.showSnackBarI(context, "Can't able to edit ", false);
    }
    state = false;
  }
}
