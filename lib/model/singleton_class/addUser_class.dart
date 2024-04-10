import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/model/adduser_model.dart';
import 'package:dating_app/model/login&signp.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:get/get.dart';

import 'package:intl/intl.dart';

class AddUserModel {
  static final _instance = AddUserModel._();

  AddUserModel._();

  factory AddUserModel() {
    return _instance;
  }


  void addUser(User? user) async {
    String? image;
    DateTime dateTime = DateTime.now();
    var time = DateFormat("HH:mm a").format(dateTime);

    var token = await FirebaseMessaging.instance.getToken();

    //base memory image:
    if (filepath.isNotEmpty) {
      var file = File(filepath.value);
      var readAsBytes = file.readAsBytesSync();
      image = base64Encode(readAsBytes);
    }

    AddUser addUsers = AddUser(
        name: user?.displayName ?? name.text,
        email: user?.email ?? "$mail",
        image: user?.photoURL ?? "$image",
        lastMessage: "HII I'm Using ChatBox",
        lastTime: time,
        online: true,
        phone: user?.phoneNumber ?? number.text,
        status: "",
        fcmToken: token);

    FirebaseFirestore.instance
        .collection("user")
        .doc(user?.uid ?? "")
        .set(addUsers.toJson());
  }
}
