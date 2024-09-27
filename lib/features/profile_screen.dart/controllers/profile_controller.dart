import 'dart:developer';
import 'dart:io';
import 'package:blizerpay/features/bottom_navigation/home/repository/home_repository.dart';
import 'package:blizerpay/features/bottom_navigation/home/screens/home_screen.dart';
import 'package:blizerpay/features/profile_screen.dart/repository/profile_repository.dart';
import 'package:blizerpay/features/profile_screen.dart/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends ChangeNotifier {
  File? finalimageFile;
  ProfileRepository repo = ProfileRepository();
  HomeRepository homerepo = HomeRepository();
  bool isLodoading = false;
  bool personalDataIsLoading = false;
  bool deleteIsLoading = false;
  Map<String, dynamic> personalData = {};

  Future<void> pickImage(BuildContext context, ImageSource source ,WidgetRef ref) async {
    isLodoading = true;
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      finalimageFile = File(pickedFile.path);
      log("$finalimageFile");
      notifyListeners();
      await repo.postImage(finalimageFile!);
       ref.read(profileController.notifier).getPersonalData();
      isLodoading = false;
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  Future<void> getPersonalData() async {
    personalDataIsLoading = true;
    final response = await homerepo.getPersonalDetailes();

    if (!personalData.containsKey("error")) {
      personalData = response;
    }
    personalDataIsLoading = false;
    notifyListeners();
  }
  Future<void> deletImage(context) async {
    deleteIsLoading = true;
     await repo.deletImageFromServer();

    if (!personalData.containsKey("error")) {
     Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
    }
    deleteIsLoading = false;
    notifyListeners();
  }
}
