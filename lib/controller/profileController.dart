// ignore_for_file: prefer_const_constructors



import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';


class ProfileController extends GetxController {
  var user = FirebaseAuth.instance.currentUser;

  String? photo = "";
  String? name;
  String? number;
  String? email;
  String? lastMessage;
 String? chatRoomId;
 List<QueryDocumentSnapshot>? document;

  @override
  void onInit() {
    super.onInit();
    FirebaseFirestore.instance
        .collection("user")
        .get()
        .then((value) => {});

    var args = Get.arguments as Map<String, dynamic>;
    photo = args["image"];
    name = args["name"];
    number = args["phone"];
    email = args["email"];
    lastMessage = args["lastMessage"];
    chatRoomId=args["chatRoomId"];
  }
}
