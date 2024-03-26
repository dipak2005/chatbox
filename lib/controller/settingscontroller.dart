
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/view/home/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  RxBool isDark = RxBool(false);

  void changeTheme(bool dark) {
      isDark.value=!isDark.value;
      if(isDark.isTrue){
        Get.changeTheme(ThemeData.dark(useMaterial3: true));
      }else{
        Get.changeTheme(ThemeData.light(useMaterial3: true));
      }
  }

  void goProfile(){
     Get.to(()=>Profile());
  }

  @override
  void onInit() {
    FirebaseFirestore.instance.collection("user").get().then((value) => {
      print("data inserted")
    });
    super.onInit();
  }
}
