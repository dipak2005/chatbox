// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';

import 'package:dating_app/controller/imagecontroller.dart';
import 'package:dating_app/model/adduser_model.dart';
import 'package:dating_app/view/home/home.dart';
import 'package:dating_app/view/login/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../model/login&signp.dart';

class UserImage extends StatelessWidget {
  final ImageController controller = Get.put(ImageController());

  UserImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Set Your Profile")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                height: MediaQuery.sizeOf(context).height / 3,
                width: MediaQuery.sizeOf(context).width / 1,
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Center(
                    child: Column(
                  children: [
                    Obx(
                      () => CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.black12,
                        backgroundImage: filepath.isNotEmpty
                            ? FileImage(File(filepath.value))
                            : null,
                        child: filepath.isEmpty
                            ? IconButton(
                                onPressed: () {
                                  pickImage(true);
                                },
                                icon: Icon(
                                  Icons.camera_alt_rounded,
                                ),
                              )
                            : SizedBox.shrink(),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        pickImage(false);
                      },
                      child: Text("Edit Picture"),
                    ),
                  ],
                )),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height / 2.7,
          ),
          Obx(
            () => ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                    filepath.isEmpty ? Colors.grey : Colors.green),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11))),
                fixedSize: MaterialStatePropertyAll(
                  Size(MediaQuery.sizeOf(context).width / 1.1,
                      MediaQuery.sizeOf(context).height / 17),
                ),
              ),
              onPressed: () {
                filepath.isEmpty ? null : Get.to(() => Signup());
              },
              child: Text(
                "Continue ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
