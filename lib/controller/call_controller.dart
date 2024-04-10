import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CallController extends GetxController{


  @override
  void onInit() {
    FirebaseFirestore.instance
        .collection("user")
        .get()
        .then((value) => {});
    super.onInit();
  }


}