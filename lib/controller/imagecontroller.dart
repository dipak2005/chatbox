import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../model/adduser_model.dart';

class ImageController extends GetxController{
  RxString filepath="".obs;


  void pickImage(bool isCamara) async {
    XFile? file = await ImagePicker()
        .pickImage(source: isCamara ? ImageSource.camera : ImageSource.gallery);
    filepath.value = file!.path;
             AddUser(image: filepath.value);
  }
}