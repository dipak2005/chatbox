import 'dart:convert';
import 'dart:io';

import 'package:dating_app/model/adduser_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

TextEditingController mail = TextEditingController();
TextEditingController name = TextEditingController();
TextEditingController password = TextEditingController();
TextEditingController newPassword = TextEditingController();
TextEditingController number = TextEditingController();
TextEditingController chatMessage = TextEditingController();
TextEditingController search = TextEditingController();

RxString filepath = "".obs;

void pickImage(bool isCamara) async {
  XFile? file = await ImagePicker()
      .pickImage(source: isCamara ? ImageSource.camera : ImageSource.gallery);
  filepath.value = file!.path;




}
