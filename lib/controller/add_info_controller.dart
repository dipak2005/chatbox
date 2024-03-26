import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddInfoConToLLer extends GetxController {
  RxString filepath = "".obs;
String image="";
  Future<void> pickImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    filepath.value = image?.path ?? "";
  }

  GlobalKey<FormState> editKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    var args=Get.arguments;
    image=args["photo"];
  }


}
