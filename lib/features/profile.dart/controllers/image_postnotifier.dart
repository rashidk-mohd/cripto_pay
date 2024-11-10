
import 'dart:io';

import 'package:blizerpay/features/bottom_navigation/home/repository/home_repository.dart';
import 'package:blizerpay/features/profile.dart/repository/profile_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImagePostApi extends StateNotifier<ApiHandler> {
  final ProfileRepository repository;
  final HomeRepository homeRepository;
  ImagePostApi(this.repository,this.homeRepository) : super(ApiHandler(loading: false));
  Future<ApiHandler> posImagetoServer(File file) async {
    state = ApiHandler(loading: true);
    final response = await repository.postImage(file);
    await homeRepository.getPersonalDetailes();
    if (!response.containsKey("error")) {
      state = ApiHandler(loading: false);
      return ApiHandler(loading: false, error: null, response: response);
    } else {
      state = ApiHandler(loading: false);
      return ApiHandler(error: response, loading: false, response: null);
    }
  }
}

class ApiHandler {
  Map<String, dynamic>? error;
  Map<String, dynamic>? response;
  bool loading=false;

  ApiHandler({this.error, required this.loading, this.response});
}
