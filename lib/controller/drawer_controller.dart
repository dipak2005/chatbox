import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DrawersController extends GetxController{



  @override
  void onInit() {
    super.onInit();
    FirebaseFirestore.instance.collection("user").get().then((value) => {
      print("data inserted")
    });
  }
}