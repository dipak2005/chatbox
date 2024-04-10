import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/view/home/pages/chat_room.dart';
import 'package:get/get.dart';

class ContactController extends GetxController {

  RxInt cIndex=0.obs;

  @override
  void onInit() {
    FirebaseFirestore.instance
        .collection("user")
        .get()
        .then((value) => {});
    super.onInit();
  }


  void changeIndex(int index){
     cIndex.value=index;
  }
  void goChat(Map<String, dynamic> data) {
    Get.to(()=>ChatRoom(), arguments: data);

  }
}
