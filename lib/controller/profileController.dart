import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/view/home/add_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController{

  var user = FirebaseAuth.instance.currentUser;

String photo="";
  @override
  void onInit() {
    FirebaseFirestore.instance.collection("user").get().then((value) => {
      print("data inserted")
    });
    super.onInit();
  }


void goEdit(){

}
}