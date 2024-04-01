import 'package:get/get.dart';

class PhotoController extends GetxController{

  String? photo;
  String? name;
  @override
  void onInit() {
    super.onInit();
    var args=Get.arguments;
    photo=args["image"];
    name=args["name"];
  }

}