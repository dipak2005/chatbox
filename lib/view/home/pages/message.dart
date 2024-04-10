// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/controller/message_controller.dart';
import 'package:dating_app/model/login&signp.dart';
import 'package:dating_app/view/home/docs/post_maker.dart';
import 'package:dating_app/view/home/docs/post_viewer.dart';
import 'package:dating_app/view/home/pages/chat_room.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../docs/photobar.dart';
import 'drawer.dart';

class Message extends StatelessWidget {
  final MessageController controller = Get.put(MessageController());

  Message({super.key});

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => (!controller.isShow.value)
              ? Text(
                  "ChatBox",
                  style: TextStyle(
                      fontSize: Theme.of(context)
                          .appBarTheme
                          .titleTextStyle
                          ?.fontSize,
                      fontWeight: FontWeight.w700,
                      color: Colors.green),
                )
              : TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: search,
                  onChanged: (value) {
                    controller.filter(value);
                  },
                  decoration: InputDecoration(
                    filled: true,
                    border: InputBorder.none,
                    hintText: "Type a message",
                  ),
                ),
        ),

        actions: [
          IconButton(
            onPressed: () {
              pickImage(true);
            },
            icon: Icon(
              Icons.camera_alt_outlined,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                controller.show();
              },
              icon: Icon(
                Icons.search_outlined,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("chats")
                  .where("email", isEqualTo : user?.email)
                  // .where("receiverMail",
                  //     isEqualTo: user?.email)
                  // .orderBy("lastTime", descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                // controller.foundData.assignAll(snapshot.data?.docs ?? []);
                var data = snapshot.data?.docs ?? [];
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      var userData = data[index];
                      Map<String, dynamic> item =
                          userData.data() as Map<String, dynamic>;
                      print(userData.id);
                      controller.receiverId.value = item["receiverId"];
                      controller.senderMail = item["senderMail"];
                      Timestamp now = item["time"];
                      DateTime currentTime = now.toDate();
                      var userTime = DateFormat("hh:mm a").format(currentTime);
                      currentTime.difference(currentTime).inDays == 0;
                      return StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("user")
                              .doc("${item["receiverId"]}")
                              .snapshots(),
                          builder: (context, snapshot) {
                            var userDetails =
                                snapshot.data?.data() as Map<String, dynamic>?;

                            return Dismissible(
                              direction: DismissDirection.startToEnd,
                              onDismissed: (direction) {
                                controller.chatData.removeAt(index);
                              },
                              background: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                decoration:
                                    BoxDecoration(color: Colors.green.shade50),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.green.shade300,
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.delete_forever)),
                                  ),
                                ),
                              ),
                              key: Key(data.length.toString()),
                              child: Card(
                                elevation: 0,
                                child: ListTile(
                                  onTap: () {
                                    var uid = FirebaseAuth
                                            .instance.currentUser?.uid ??
                                        "";
                                    isRead.value = true;
                                    var id = ((uid == item["receiverId"])
                                        ? item["senderId"]
                                        : item["receiverId"]);
                                    var email = ((uid == item["receiverId"])
                                        ? item["senderMail"]
                                        : item["receiverMail"]);
                                    Get.to(() => ChatRoom(), arguments: {
                                      "id": id,
                                      "email": email,
                                      "photo": userDetails?["image"],
                                      "name": userDetails?["name"],
                                    });
                                    print(userData.id);
                                  },
                                  leading: Container(
                                      height: 50,
                                      width: 50,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Colors.white),
                                      child: InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height /
                                                        3,
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                        .width,
                                                child: AlertDialog(
                                                  content: InkWell(
                                                    onTap: () {
                                                      Get.to(() => PhotoBar(),
                                                          arguments: {
                                                            "image":
                                                                userDetails?[
                                                                    "image"],
                                                            "name":
                                                                userDetails?[
                                                                    "name"],
                                                          });
                                                    },
                                                    child: ("${userDetails?["image"]}")
                                                            .startsWith(
                                                                "https://")
                                                        ? Image.network(
                                                            ("${userDetails?["image"]}"),
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Image.memory(
                                                            base64Decode(
                                                                "${userDetails?["image"]}"),
                                                            fit: BoxFit.cover),
                                                  ),
                                                  actions: [
                                                    IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(
                                                          Icons
                                                              .message_outlined,
                                                          color: Colors.green),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(
                                                          Icons.call_outlined,
                                                          color: Colors.green),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(
                                                          Icons
                                                              .videocam_outlined,
                                                          color: Colors.green),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(Icons.add,
                                                          color: Colors.green),
                                                    ),
                                                  ],
                                                  title: Text(
                                                    "${userDetails?["name"]}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: CircleAvatar(
                                            radius: 50,
                                            child: ("${userDetails?["image"]}")
                                                    .startsWith("https://")
                                                ? Image.network(
                                                    ("${userDetails?["image"]}"),
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.memory(
                                                    base64Decode(
                                                        "${userDetails?["image"]}"),
                                                    fit: BoxFit.cover)),
                                      )),
                                  title: Text(
                                  "${item["name"]}"

                                 ),
                                  subtitle: Text("${item["message"]}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1),
                                  trailing: (currentTime
                                              .difference(currentTime)
                                              .inDays ==
                                          1)
                                      ? Text("yesterday")
                                      : Text(userTime),
                                ),
                              ),
                            );
                          });
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ],
      ),
      drawer: DrawerApp(),
    );
  }
}
