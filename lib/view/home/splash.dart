// ignore_for_file: prefer_const_constructors

import 'package:dating_app/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatelessWidget {
  final SplashController controller = Get.put(SplashController());

  Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child:
                  Hero(tag: "image", child: Image.asset("assets/splash.png"))),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
