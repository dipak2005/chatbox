// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:dating_app/controller/media_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Media extends StatelessWidget {
  final MediaController controller = Get.put(MediaController());

  Media({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${controller.name}'s Media"),
      ),
      body: GridView.builder(
        itemCount: controller.argsList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          var data = controller.argsList[index];
          var image = data.data() as Map<String, dynamic>?;

          return Container(
            height: MediaQuery.sizeOf(context).height / 7,
            width: MediaQuery.sizeOf(context).width / 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ("${image?["image"]}".isNotEmpty)
                ? Image.file(File(image?["image"]))
                : null,
          );
        },
      ),
    );
  }
}
