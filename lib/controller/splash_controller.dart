// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    goto();
    super.onInit();
  }

  void goto() {
    Timer(Duration(seconds: 2), () {
      Get.offNamed("login");
    });
  }
}
