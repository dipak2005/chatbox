// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'dart:convert';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/controller/message_controller.dart';
import 'package:dating_app/model/login&signp.dart';
import 'package:dating_app/view/home/docs/post_maker.dart';
import 'package:dating_app/view/home/docs/post_viewer.dart';
import 'package:dating_app/view/home/pages/chat_room.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
        centerTitle: true,
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
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height / 7,
                width: MediaQuery.sizeOf(context).width / 1,
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("user")
                        .orderBy("lastTime", descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      var data = snapshot.data?.docs ?? [];
                      return ListView.builder(
                        itemCount: data.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var Data = data[index];
                          var userData = Data.data() as Map<String, dynamic>?;
                          bool isLogUser =
                              Data.id == controller.receiverId.value;
                          print("object  ${Data.id}");
                          return Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(() => PostViewer());
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.green.shade300,
                                  radius: 60,
                                  child: Container(
                                    height:
                                        MediaQuery.sizeOf(context).height / 3.1,
                                    width:
                                        MediaQuery.sizeOf(context).width / 3.3,
                                    margin: EdgeInsets.all(4),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: userData != null &&
                                            userData["image"] != null &&
                                            (("${userData["image"]}")
                                                .startsWith("https://"))
                                        ? Image.network(
                                            ("${userData["image"]}"),
                                            fit: BoxFit.cover,
                                          )
                                        : Image.memory(
                                            base64Decode(
                                                "${userData?["image"]}"),
                                            fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                              (data[index] == data.first)
                                  ? Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Center(
                                        child: CircleAvatar(
                                            backgroundColor:
                                                Colors.green.shade300,
                                            radius: 20,
                                            child: IconButton(
                                                onPressed: () async {
                                                  // await [

                                                  // ].request();
                                                  Get.to(() => PostMaker());
                                                },
                                                icon: Icon(
                                                  Icons.add,
                                                  color: Theme.of(context)
                                                      .primaryColorDark,
                                                ))),
                                      ),
                                    )
                                  : SizedBox.shrink()
                            ],
                          );
                        },
                      );
                    }),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height / 30,
              ),
              Container(
                clipBehavior: Clip.antiAlias,
                height: MediaQuery.sizeOf(context).height / 0.9,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.90, 0.9),
                        blurStyle: BlurStyle.outer,
                        blurRadius: 10)
                  ],
                ),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("chats")
                      .where("receiverMail", isNotEqualTo: user?.email)
                      // .where("senderMail",
                      //     isEqualTo: controller.receiverId.value)
                      // .orderBy("lastTime", descending: false)
                      .snapshots(),

                  builder: (context, snapshot) {
                    controller.foundData.assignAll(snapshot.data?.docs ?? []);

                    if (snapshot.hasError) {
                      return Text("Error :${snapshot.error}");
                    }
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      default:
                        return Obx(
                          () => ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.foundData.length,
                            itemBuilder: (context, index) {
                              var userData = controller.foundData[index];
                              Map<String, dynamic> item =
                                  userData.data() as Map<String, dynamic>;
                              print(userData.id);
                              controller.receiverId.value = item["receiverId"];
                              controller.senderMail = item["senderMail"];
                              Timestamp now = item["time"];
                              DateTime currentTime = now.toDate();
                              var userTime =
                                  DateFormat("hh:mm a").format(currentTime);
                              return Card(
                                elevation: 0,
                                child: StreamBuilder<DocumentSnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection("user")
                                        .doc("${item["receiverId"]}")
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      var userDetails = snapshot.data?.data()
                                          as Map<String, dynamic>?;

                                      return Dismissible(
                                        direction: DismissDirection.startToEnd,
                                        onDismissed: (direction) {
                                          controller.chatData.removeAt(index);
                                        },
                                        background: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          decoration: BoxDecoration(
                                              color: Colors.green.shade50),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CircleAvatar(
                                                backgroundColor:
                                                    Colors.green.shade300,
                                                child: IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(
                                                        Icons.delete_forever)),
                                              )
                                            ],
                                          ),
                                        ),
                                        key: Key(userTime),
                                        child: ListTile(
                                          onTap: () {
                                            var uid = FirebaseAuth.instance
                                                    .currentUser?.uid ??
                                                "";

                                            var id =
                                                ((uid == item["receiverId"])
                                                    ? item["senderId"]
                                                    : item["receiverId"]);
                                            var email =
                                                ((uid == item["receiverId"])
                                                    ? item["senderMail"]
                                                    : item["receiverMail"]);
                                            Get.to(() => ChatRoom(),
                                                arguments: {
                                                  "id": id,
                                                  "email": email,
                                                  "photo":
                                                      userDetails?["image"],
                                                  "name": userDetails?["name"]
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
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height /
                                                                3,
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                    context)
                                                                .width,
                                                        child: AlertDialog(
                                                          content: InkWell(
                                                            onTap: () {
                                                              Get.to(
                                                                  () =>
                                                                      PhotoBar(),
                                                                  arguments: {
                                                                    "image":
                                                                        userDetails?[
                                                                            "image"],
                                                                    "name": userDetails?[
                                                                        "name"],
                                                                  });
                                                            },
                                                            child: ("${userDetails?["image"]}")
                                                                    .startsWith(
                                                                        "https://")
                                                                ? Image.network(
                                                                    ("${userDetails?["image"]}"),
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  )
                                                                : Image.memory(
                                                                    base64Decode(
                                                                        "${userDetails?["image"]}"),
                                                                    fit: BoxFit
                                                                        .cover),
                                                          ),
                                                          actions: [
                                                            IconButton(
                                                              onPressed: () {},
                                                              icon: Icon(
                                                                  Icons
                                                                      .message_outlined,
                                                                  color: Colors
                                                                      .green),
                                                            ),
                                                            IconButton(
                                                              onPressed: () {},
                                                              icon: Icon(
                                                                  Icons
                                                                      .call_outlined,
                                                                  color: Colors
                                                                      .green),
                                                            ),
                                                            IconButton(
                                                              onPressed: () {},
                                                              icon: Icon(
                                                                  Icons
                                                                      .videocam_outlined,
                                                                  color: Colors
                                                                      .green),
                                                            ),
                                                            IconButton(
                                                              onPressed: () {},
                                                              icon: Icon(
                                                                  Icons.add,
                                                                  color: Colors
                                                                      .green),
                                                            ),
                                                          ],
                                                          title: Text(
                                                            "${userDetails?["name"]}",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                                child: CircleAvatar(
                                                    radius: 50,
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
                                                            fit: BoxFit.cover)),
                                              )),
                                          title: Text(((user?.uid ==
                                                  controller.receiverId.value))
                                              ? "${userDetails?["name"]}"
                                              : "${userDetails?["name"]}"),
                                          subtitle: Text("${item["message"]}",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1),
                                          trailing: Text(userTime),
                                        ),
                                      );
                                    }),
                              );
                            },
                          ),
                        );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
      drawer: DrawerApp(),
    );
  }
}
/*
 leading: StreamBuilder<DocumentSnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection("user")
                                          .doc(user?.uid)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        var username = snapshot.data?.data()
                                            as Map<String, dynamic>?;
                                        controller.image =
                                            "${username?["image"]}";
                                        controller.name =
                                            "${item["name"]}";
                                        return Container(
                                            height: 50,
                                            width: 50,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.white),
                                            child: CircleAvatar(
                                              child: Image.network(
                                                  "${username?["image"]}",
                                                  fit: BoxFit.cover),
                                            ));
                                      }),
 */
