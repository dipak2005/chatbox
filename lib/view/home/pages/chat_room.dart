// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/model/userchat_model.dart';
import 'package:dating_app/view/home/pages/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dating_app/controller/chat_controller.dart';
import 'package:url_launcher/url_launcher.dart';

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
          child: (controller.photo != null)
              ? Image.network(controller.photo ?? "")
              : Image.asset("assets/profile.png"),
        ),
        title: ListTile(
          title: Text(controller.email ?? "",
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 1),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.video_chat_outlined),
          ),
          IconButton(
            onPressed: () {
             var phone= Uri.parse(" +91${controller.phone}");
              launchUrl(phone);
              print("object");
            },
            icon: Icon(Icons.phone_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("chats")
                        .doc(controller.chatRoomId.value)
                        .collection("messages")
                        .orderBy("time", descending: false)
                        .snapshots(),
                    builder: (context, snapshot) {
                      List<QueryDocumentSnapshot> data =
                          snapshot.data?.docs ?? [];
                      if (snapshot.hasError) {
                        return Text("Error :${snapshot.error}");
                      }

                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(child: CircularProgressIndicator());
                        default:
                          return ListView.builder(
                            controller: ScrollController(),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              var messageList = data[index];
                              var message =
                                  messageList.data() as Map<String, dynamic>;

                              bool isLogUser =
                                  controller.senderId == message["senderId"];

                              return Align(
                                alignment: isLogUser
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(
                                          MediaQuery.sizeOf(context).width *
                                              0.05),
                                      margin: EdgeInsets.symmetric(
                                          horizontal:
                                              MediaQuery.sizeOf(context).width *
                                                  0.04,
                                          vertical: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.01),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: (isLogUser)
                                                ? Colors.green
                                                : Colors.blue),
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(
                                              (!isLogUser) ? 20 : 0),
                                          topRight: Radius.circular(20),
                                          topLeft: Radius.circular(
                                              (isLogUser) ? 20 : 0),
                                          bottomLeft: Radius.circular(20),
                                        ),
                                      ),
                                      child: InkWell(
                                        onTap: () async {
                                          var future = await FirebaseFirestore
                                              .instance
                                              .collection("chat")
                                              .doc(controller.chatRoomId.value)
                                              .collection("messages")
                                              .get();

                                          print(
                                              "${message["message"]}   ${message["senderId"]} ${message["senderMail"]} ${message["senderMessage"]}   ${message["time"]}");
                                        },
                                        child: Text(
                                          message["message"],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text("${message["time"]}"),
                                        Icon(Icons.done_all)
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                      }
                    }),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  color: Colors.white,
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
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            controller: controller.chatMessage,
                            onEditingComplete: () {
                              if (controller.chatMessage.text.isNotEmpty) {
                                controller.userChat(
                                    controller.email ?? "",
                                    controller.id ?? "",
                                    controller.chatMessage.text);
                              }
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Type a message",
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.attach_file),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.camera_alt_outlined),
                        ),
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 23,
                  backgroundColor: Colors.green,
                  child: Padding(
                    padding: EdgeInsets.only(right: 10, top: 10, bottom: 10),
                    child: MaterialButton(
                        onPressed: () async {
                          if (controller.chatMessage.text.isNotEmpty) {
                            controller.userChat(
                              controller.email ?? "",
                              controller.id ?? "",
                              controller.chatMessage.text,
                            );
                          }
                          print("halo hu call thavu hu");
                          print(controller.chatMessage.text);
                          controller.chatMessage.clear();
                        },
                        child: Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                        )),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 48.0),
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            var index = 0;
            if (index == 0) {}
          },
          child: Icon(Icons.arrow_downward),
        ),
      ),
    );
  }
}
