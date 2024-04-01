// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:dating_app/controller/chat_controller.dart';
import 'package:dating_app/view/home/pages/chat_room.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/login&signp.dart';

class ImageSender extends StatelessWidget {
  final ChatController controller = Get.find<ChatController>();

  ImageSender({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: [],
      ),
      body: Column(
        children: [
          Text(
            "${controller.filepath.value}",
            style: TextStyle(color: Colors.black),
          ),
          Text("${filepath.value}"),
          Expanded(
            child: Container(
              height: MediaQuery.sizeOf(context).height / 2.3,
              width: MediaQuery.sizeOf(context).width,
              child: Image.file(
                File(controller.filepath.value),
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width / 1.2,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.emoji_emotions_outlined)),
                      Expanded(
                        child: TextFormField(
                          onTap: () {},
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: chatMessage,
                          onEditingComplete: () {
                            if (chatMessage.text.isNotEmpty) {
                              controller.userChat(
                                  controller.email ?? "",
                                  controller.id ?? "",
                                  chatMessage.text,
                                  DateTime.now().toString(),
                                  false,
                                  "");
                            }
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Type a message",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 23,
                backgroundColor: Colors.green,
                child: IconButton(
                    onPressed: () async {
                      if (controller.filepath.value.isEmpty) {
                        controller.userChat(
                            controller.email ?? "",
                            controller.id ?? "",
                            chatMessage.text,
                            DateTime.now().toString(),
                            false,
                            "");
                      } else {
                        controller.userChat(
                            controller.email ?? "",
                            controller.id ?? "",
                            chatMessage.text,
                            DateTime.now().toString(),
                            false,
                            controller.filepath.value);
                        Get.to(() => ChatRoom());
                      }

                      print("halo hu call thavu hu");

                      chatMessage.clear();
                    },
                    icon: Icon(
                      (Icons.send_rounded),
                      color: Colors.white,
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
