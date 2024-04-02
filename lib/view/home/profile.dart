// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/controller/profileController.dart';
import 'package:dating_app/view/home/docs/media.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_info.dart';

class Profile extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  Profile({super.key});

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text("View Profile"),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text("Edits"),
                  onTap: () {
                    Get.to(() => AddInfo(),
                        arguments: {"photo": controller.photo});
                  },
                ),
                PopupMenuItem(
                  child: Text("Media"),
                  onTap: () {
                    Get.to(() => Profile());
                  },
                ),
                PopupMenuItem(child: Text("Share")),
              ];
            },
          )
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 60,backgroundColor: Colors.green,
            child: Container(
              height: MediaQuery.sizeOf(context).height / 3.1,
              width: MediaQuery.sizeOf(context).width / 3.3,
              margin: EdgeInsets.all(4),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(100)),
              child: (controller.photo ?? "").startsWith("https://")
                  ? Image.network(
                      (controller.photo ?? ""),
                      fit: BoxFit.cover,
                    )
                  : Image.memory(base64Decode(controller.photo ?? ""),
                      fit: BoxFit.cover),
            ),
          ),
          Text(
            controller.name ?? "",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: Theme.of(context).textTheme.displaySmall?.fontSize,
            ),
          ),
          Text(
            controller.lastMessage ?? "",
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: icon.length,
              itemBuilder: (context, index) {
                var icons = icon[index];
                return Container(
                  margin: EdgeInsets.all(20),
                  child: CircleAvatar(
                    backgroundColor: Colors.lightGreen.shade50,
                    child: IconButton(
                      onPressed: () {},
                      icon: icons,
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            height: MediaQuery.sizeOf(context).height / 1.8,
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(
                right: Radius.circular(40),
                left: Radius.circular(40),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    blurStyle: BlurStyle.outer,
                    offset: Offset(0.9, 0.9),
                    blurRadius: 10)
              ],
            ),
            child: Column(
              children: [
                Card(
                  margin: EdgeInsets.only(top: 20),
                  elevation: 0,
                  child: ListTile(
                    title: Text(
                      "Display Name",
                      style: TextStyle(fontSize: 13),
                    ),
                    subtitle: Text(
                      controller.name ?? "",
                      style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.titleMedium?.fontSize,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Card(
                  elevation: 0,
                  child: ListTile(
                    title: Text(
                      "Email Address",
                      style: TextStyle(fontSize: 13),
                    ),
                    subtitle: Text(
                      controller.email ?? "",
                      style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.titleMedium?.fontSize,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Card(
                  elevation: 0,
                  child: ListTile(
                    title: Text(
                      "Phone Number",
                      style: TextStyle(fontSize: 13),
                    ),
                    subtitle: Text(
                      controller.number ?? "",
                      style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.titleMedium?.fontSize,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Media Shared"),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 2.2,
                    ),
                    TextButton(
                        onPressed: () {
                          Get.to(() => Media(), arguments: [
                            controller.document,
                            controller.name ?? ""
                          ]);
                        },
                        child: Text("View All"))
                  ],
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("chats")
                      .doc(controller.chatRoomId)
                      .collection("messages")
                      .snapshots(),
                  builder: (context, snapshot) {
                    List<QueryDocumentSnapshot> data =
                        snapshot.data?.docs ?? [];
                    return SizedBox(
                      height: MediaQuery.sizeOf(context).height / 5.6,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          var Data = data[index];
                          var imageData = Data.data() as Map<String, dynamic>?;
                          print(data.length);
                          controller.document = data;
                          return Container(
                            height: MediaQuery.sizeOf(context).height / 7,
                            width: MediaQuery.sizeOf(context).width / 3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ("${imageData?["image"]}".isNotEmpty)
                                ? Image.file(File(imageData?["image"]))
                                : null,
                          );
                        },
                      ),
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

List<Icon> icon = [
  Icon(Icons.message),
  Icon(Icons.videocam_outlined),
  Icon(Icons.call_outlined),
  Icon(Icons.more_horiz),
];
