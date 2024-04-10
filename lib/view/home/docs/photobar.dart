// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:dating_app/controller/photocontroller.dart';
import 'package:dating_app/model/login&signp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhotoBar extends StatelessWidget {
  final PhotoController controller = Get.put(PhotoController());

  PhotoBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        backgroundColor: Colors.black,
        title:
            Text(controller.name ?? "", style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Container(
            // clipBehavior: Clip.antiAlias,
            // decoration:
            //     BoxDecoration(borderRadius: BorderRadius.circular(180)),
            child: Stack(
          children: [
            (controller.photo ?? "").startsWith("https://")
                ? Image.network(
                    controller.photo ?? "",
                    fit: BoxFit.fitWidth,
                    width: MediaQuery.sizeOf(context).width,
                  )
                : ((controller.photo ?? "").startsWith("/data/"))
                    ? Image.file(
                        File(controller.photo ?? ""),
                        fit: BoxFit.cover,
                      )
                    : (controller.photo ?? "").startsWith("assets/")
                        ? Image.asset(
                            controller.photo ?? "",
                            fit: BoxFit.fitHeight,
                            height: MediaQuery.sizeOf(context).height,
                          )
                        : Image.memory(
                            base64Decode(controller.photo ?? ""),
                            fit: BoxFit.cover,
                            width: MediaQuery.sizeOf(context).width,
                          ),
            (controller.photo ?? "").startsWith("assets/")? Positioned(
              bottom: 10,
              right: 100,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Color(0xff023404),
                  ),
                ),
                onPressed: () {
                  background=controller.photo??"";

                },
                child: Text("Set Wallpaper",style: TextStyle(color: Colors.white)),
              ),
            ):SizedBox.shrink()
          ],
        )),
      ),
    );
  }
}
