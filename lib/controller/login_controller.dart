// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:dating_app/main.dart';
import 'package:dating_app/model/singleton_class/addUser_class.dart';
import 'package:dating_app/view/home/home.dart';
import 'package:dating_app/view/login/forgetpassword.dart';
import 'package:dating_app/view/login/login1.dart';
import 'package:dating_app/view/login/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../model/login&signp.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> gKey = GlobalKey<FormState>();

  void goto() {
    Get.to(() => Login1());
  }

  void goMail() {
    Get.to(() => Signup());
  }

  void goLogin() {
    if (gKey.currentState?.validate() ?? false) {
      Get.to(() => Home());
    }
    mail.clear();
    password.clear();
  }

  void goPassword() {
    Get.to(() => ForgetPassword());
  }

  void googleSignIn() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Get.showSnackbar(GetSnackBar(
        title: "Login",
        backgroundColor: Colors.green,
        duration: Duration(microseconds: 500),
        message: "All Ready Exist",
      ));
      Get.off(() => Home());
    } else {
      var google = await GoogleSignIn().signIn();

      var auth = await google?.authentication;
      var credential = GoogleAuthProvider.credential(
          accessToken: auth?.accessToken, idToken: auth?.idToken);

      // must be
      var data = await FirebaseAuth.instance.signInWithCredential(credential);
      print("$credential");
      User? userData = data.user;
      // AddUserModel().addUser(userData);
      if (filepath.value.isEmpty) {
        AddUserModel().addUser(userData);
      }

      Get.showSnackbar(GetSnackBar(
        title: "Login",
        backgroundColor: Colors.green,
        duration: Duration(microseconds: 500),
        message: "User Added Successfully",
      ));
      Get.off(() => Home());
    }
  }
}
