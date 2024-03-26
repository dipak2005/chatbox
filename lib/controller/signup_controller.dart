// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:dating_app/model/adduser_model.dart';
import 'package:dating_app/model/singleton_class/addUser_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../model/login&signp.dart';
import '../view/home/home.dart';

class SignupController extends GetxController {
  RxBool isTerm = RxBool(false);
  // TextEditingController mail = TextEditingController();
  // TextEditingController name = TextEditingController();
  // TextEditingController password = TextEditingController();
  // TextEditingController newPassword = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  RxString? value;

  void goto() async {
    if (globalKey.currentState?.validate() ?? false) {
      FocusScope.of(Get.context!).unfocus();
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: mail.text, password: password.text);
      AddUserModel().addUser(user.user);
      AddUser(name: name.text,email: mail.text,phone: number.text);
      GetSnackBar(
        title: "Register",
        backgroundColor: Colors.green,
        message: "User Added SuccessFully",
        duration: Duration(seconds: 2),
      );
      Get.toNamed("home");
    }

  }

  void googleSignIn() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Get.showSnackbar(GetSnackBar(
        title: "Login",
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
        message: "User Already Login",
      ));
    } else {
      var google = await GoogleSignIn().signIn();

      var auth = await google?.authentication;
      var credential = GoogleAuthProvider.credential(
          accessToken: auth?.accessToken, idToken: auth?.idToken);

      // must be
      var data = await FirebaseAuth.instance.signInWithCredential(credential);
      print("$credential");
      User? userData = data.user;
            AddUserModel().addUser(userData);
      // GoogleSignIn().signOut();
      // FirebaseAuth.instance.signOut();
      Get.showSnackbar(GetSnackBar(
        title: "Login",
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
        message: "User Added Successfully",
      ));
      Timer(Duration(seconds: 3), () {
        Get.to(()=>Home());
      });
    }
  }

  // void gotoLogin1() {
  //   Get.toNamed("log1");
  // }
  //
  // void goMail() {
  //
  //   Get.toNamed("signup");
  // }
  //
  // void goLogin(){
  //
  //   Get.toNamed("home");
  // }
  //
  // void goPassword() {
  //   Get.toNamed("password");
  // }


}
