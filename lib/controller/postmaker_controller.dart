import 'dart:ui';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PostMakerController extends GetxController {
  RxString filepath = "".obs;
  RxList<XFile>? imageFile = RxList<XFile>();

  Future<void> pickImage(bool isCamera) async {
    XFile? file = await ImagePicker()
        .pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery);
    filepath.value = file?.path ?? "";
  }

  Future<void> pickVideo(bool isCamera) async {
    XFile? file = await ImagePicker()
        .pickVideo(source: isCamera ? ImageSource.camera : ImageSource.gallery);
    filepath.value = file?.path ?? "";
  }

  Future<void> pickMultiImage() async {
    try {
      final List<XFile> images = await ImagePicker().pickMultiImage();
      imageFile?.value = images;
    } catch (e) {

    }
  }

  Future<void> requestPermission() async {}
}
