import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/model/adduser_model.dart';
import 'package:dating_app/model/login&signp.dart';
import 'package:dating_app/model/userchat_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddUserModel {
  static final _instance = AddUserModel._();

  AddUserModel._();

  factory AddUserModel() {
    return _instance;
  }

  String images =
      "https://as2.ftcdn.net/v2/jpg/05/89/93/27/500_F_589932782_vQAEAZhHnq1QCGu5ikwrYaQD0Mmurm0N.jpg";

  void addUser(User? user) {
    AddUser addUsers = AddUser(
      name: user?.displayName ?? name.text,
      email: user?.email ?? "$mail",
      image: (user?.photoURL == null) ? images : user?.photoURL,
      lastMessage: "",
      lastTime: "${DateTime.now().hour} :${DateTime.now().minute}",
      online: true,
      phone: user?.phoneNumber ?? number.text,
      status: "",
    );



    FirebaseFirestore.instance
        .collection("user")
        .doc(user?.uid ?? "")
        .set(addUsers.toJson());
  }
}
