import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ContentController extends GetxController {
  RxString filepath = "".obs;
  RxList<XFile> multiList = RxList<XFile>();

  void pickImage(bool isCamara) async {
    XFile? file = await ImagePicker()
        .pickImage(source: isCamara ? ImageSource.camera : ImageSource.gallery);
    filepath.value = file!.path;
  }

  Future<void> pickMedia(bool isCamera) async {
    XFile? file = await ImagePicker().pickMedia(
        imageQuality: 720, maxWidth: MediaQuery.sizeOf(Get.context!).width);
    filepath.value = file?.path ?? "";
  }

  Future<void> pickMultiple() async {
    List<XFile> file = await ImagePicker().pickMultiImage(
        maxWidth: MediaQuery.sizeOf(Get.context!).width, imageQuality: 1080);
    multiList.value = file;
  }
}
