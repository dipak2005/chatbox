// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/model/userchat_model.dart';
import 'package:dating_app/view/home/docs/content.dart';
import 'package:dating_app/view/home/docs/photobar.dart';
import 'package:dating_app/view/home/pages/message.dart';
import 'package:dating_app/view/home/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dating_app/controller/chat_controller.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../main.dart';
import '../../../model/login&signp.dart';

class ChatRoom extends StatelessWidget {
  final ChatController controller = Get.put(ChatController());

  ChatRoom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          height: 50,
          width: 50,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
          child: CircleAvatar(
            child: ((controller.photo ?? "").startsWith("https://")
                ? Image.network(
                    (controller.photo ?? ""),
                    fit: BoxFit.cover,
                  )
                : Image.memory(base64Decode(controller.photo ?? ""),
                    fit: BoxFit.cover)),
          ),
        ),
        title: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("user")
                .doc(controller.id ?? "")
                .snapshots(),
            builder: (context, snapshot) {
              var status = snapshot.data?.data() as Map<String, dynamic>?;
              controller.map = status;
              return Obx(
                () => ListTile(
                  onTap: () {
                    Get.to(() => Profile(), arguments: status);
                  },
                  title: Text(controller.username.value,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1),
                  subtitle: (status?["status"] == true)
                      ? Text(
                          (chatMessage.text.isEmpty) ? "Active now" : "typing",
                          style: TextStyle(fontSize: 10),
                        )
                      : Text(
                          "Last seen at ${status?["lastTime"]}",
                          style: TextStyle(fontSize: 10),
                        ),
                ),
              );
            }),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.video_chat_outlined),
          ),
          IconButton(
            onPressed: () {
              var phone = Uri.parse("whatsapp: +91${controller.phone}");
              launchUrl(phone);
              print("object");
            },
            icon: Icon(Icons.phone_outlined),
          ),
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text("View Profile"),
                  onTap: () {
                    print("controller${controller.chatRoomId.value}");
                    Get.to(() => Profile(), arguments: {
                      "image": controller.map?["image"],
                      "name": controller.map?["name"],
                      "number": controller.map?["phone"],
                      "email": controller.map?["email"],
                      "lastMessage": controller.map?["lastMessage"],
                      "chatRoomId": controller.chatRoomId.value
                    });
                  },
                ),
                PopupMenuItem(child: Text("Share")),
              ];
            },
          )
        ],
      ),
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Stack(
          children: [
            Positioned(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                child: Image.asset(
                  "assets/image6.jpg",
                  fit: BoxFit.fitHeight,
                )),
            Expanded(
              child: Obx(
                () => StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("chats")
                        .doc(controller.chatRoomId.value)
                        .collection("messages")
                        .snapshots(),
                    builder: (context, snapshot) {
                      print(controller.chatRoomId.value);
                      List<QueryDocumentSnapshot> data =
                          snapshot.data?.docs ?? [];

                      return ListView.builder(
                        controller: ScrollController(),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          var messageList = data[index];
                          var message =
                              messageList.data() as Map<String, dynamic>;

                          bool isLogUser =
                              controller.senderId == message["senderId"];
                          Timestamp now = message["time"] ?? "";
                          DateTime currentTime = now.toDate();
                          var userTime =
                              DateFormat("hh:mm a").format(currentTime);

                          // show datetime badge:
                          // controller.isToday= now.difference(now).inDays==0;
                          // controller.isYesterday= now.difference(now).inDays==1;

                          return Align(
                            alignment: isLogUser
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Column(
                              children: [
                                // Text(controller.messageDateTile("${message["time"]}" as DateTime)),
                                //  (index==0 || (index>0 && !controller.isSameDate("${message["time"]}" as DateTime, "${message["time"]}" as DateTime)))?

                                Container(
                                  padding: EdgeInsets.all(
                                      MediaQuery.sizeOf(context).width * 0.03),
                                  margin: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.sizeOf(context).width *
                                              0.04,
                                      vertical:
                                          MediaQuery.sizeOf(context).height *
                                              0.01),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    color: (isLogUser)
                                        ? Colors.green.shade200
                                        : Colors.blue.shade100,
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(
                                          (!isLogUser) ? 15 : 0),
                                      topRight: Radius.circular(15),
                                      topLeft:
                                          Radius.circular((isLogUser) ? 15 : 0),
                                      bottomLeft: Radius.circular(15),
                                    ),
                                  ),
                                  child: InkWell(
                                    onLongPress: () {
                                      controller.isDelete.value = true;

                                      showModalBottomSheet(
                                        context: Get.context!,
                                        builder: (context) {
                                          return Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(40)),
                                            height: MediaQuery.sizeOf(context)
                                                    .height /
                                                5,
                                            width: MediaQuery.sizeOf(context)
                                                .width,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    CircleAvatar(
                                                        radius: 30,
                                                        backgroundColor: Colors
                                                            .lightGreen
                                                            .shade100,
                                                        child: IconButton(
                                                            onPressed: () {},
                                                            icon: Icon(
                                                                Icons.copy))),
                                                    Text("Copy"),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width /
                                                          8,
                                                ),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 30,
                                                      backgroundColor: Colors
                                                          .lightGreen.shade100,
                                                      child: IconButton(
                                                          onPressed: () async {
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "chats")
                                                                .doc(controller
                                                                    .chatRoomId
                                                                    .value)
                                                                .collection(
                                                                    "messages")
                                                                .doc(
                                                                    "${message["time"]}")
                                                                .delete()
                                                                .then((value) =>
                                                                    {
                                                                      print(
                                                                          "deleted")
                                                                    });
                                                          },
                                                          icon: Icon(Icons
                                                              .delete_outline_outlined)),
                                                    ),
                                                    Text("Delete"),
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    onTap: () {
                                      controller.isDelete.value = false;
                                    },
                                    child: ("${message["image"]}".isEmpty)
                                        ? Text(
                                            message["message"],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14),
                                          )
                                        : InkWell(
                                            onLongPress: () {
                                              controller.isDelete.value = true;
                                            },
                                            onTap: () {
                                              Get.to(() => PhotoBar(),
                                                  arguments: message);
                                            },
                                            child: Container(
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Image.file(
                                                File(
                                                    "${message["image"][index]}"),
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height /
                                                        3,
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width /
                                                        1.7,
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                                // :SizedBox.shrink()

                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(userTime,
                                        style: TextStyle(
                                            fontSize: 10, color: Colors.white)),
                                    Icon(
                                      Icons.done_all,
                                      color: (isRead.value == true)
                                          ? Colors.blue
                                          : Colors.white,
                                      size: 19,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Row(
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
                              onPressed: () {
                                print(MediaQuery.sizeOf(context).height);
                                print(MediaQuery.sizeOf(context).width);
                              },
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
                                      false);
                                }
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Type a message",
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Content();
                                },
                              );
                            },
                            icon: Icon(Icons.attach_file),
                          ),
                          IconButton(
                            onPressed: () async {
                              if (controller.filepath.value.isEmpty) {
                                await controller.pickImage(true);
                                controller.userChat(
                                    controller.email ?? "",
                                    controller.id ?? "",
                                    chatMessage.text,
                                    DateTime.now().toString(),
                                    false,
                                    controller.filepath.value);
                                // await  Get.to(()=>ChatRoom());
                              }
                            },
                            icon: Icon(Icons.camera_alt_outlined),
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
                          if (chatMessage.text.isNotEmpty) {
                            controller.userChat(
                                controller.email ?? "",
                                controller.id ?? "",
                                chatMessage.text,
                                DateTime.now().toString(),
                                false,
                                "");
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
            ),
          ],
        ),
      ),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(bottom: 48.0),
      //   child: FloatingActionButton(
      //     backgroundColor: Colors.white,
      //     onPressed: () {
      //       var index = 0;
      //       if (index == 0) {}
      //     },
      //     child: Icon(Icons.arrow_downward),
      //   ),
      // ),
    );
  }
}

class DateBadge extends StatelessWidget {
  final DateTime date;

  const DateBadge({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      color: Colors.grey[300],
      child: Text(
        _formatDate(date),
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  String _formatDate(DateTime date) {
    // Format the date as needed
    if (DateTime.now().difference(date).inDays == 0) {
      return 'Today';
    } else if (DateTime.now().difference(date).inDays == 1) {
      return 'Yesterday';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}

// class MessageTile extends StatelessWidget {
//   final Message message;
//
//
//   const MessageTile({Key? key, required this.message, required this.isToday, required this.isYesterday})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(message.text),
//       subtitle: Text(isToday ? 'Today' : isYesterday ? 'Yesterday' : ''),
//     );
//   }
// }
