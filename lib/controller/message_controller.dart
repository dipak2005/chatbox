import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {
  @override
  void onInit() {
    FirebaseFirestore.instance.collection("user").get().then((value) => {
      print("data inserted")
    });
    super.onInit();
  }
}
