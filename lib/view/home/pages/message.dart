// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/controller/homecontroller.dart';
import 'package:dating_app/controller/message_controller.dart';
import 'package:dating_app/view/home/pages/chat_room.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'drawer.dart';

class Message extends StatelessWidget {
  final MessageController controller = Get.put(MessageController());

  Message({super.key});

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chat App",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {},
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
                child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                        height: MediaQuery.sizeOf(context).height / 2,
                        width: MediaQuery.sizeOf(context).width / 3,
                        decoration: BoxDecoration(),
                        child: CircleAvatar());
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height / 30,
              ),
              Container(
                clipBehavior: Clip.antiAlias,
                height: MediaQuery.sizeOf(context).height / 0.9,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  color: Colors.white,
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
                      .where("senderMail",
                          isEqualTo:
                              FirebaseAuth.instance.currentUser?.email ?? "")
                      .snapshots(),
                  builder: (context, snapshot) {
                    var data = snapshot.data?.docs ?? [];
                    if (snapshot.hasError) {
                      return Text("Error :${snapshot.error}");
                    }
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      default:
                        return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            var userData = data[index];
                            Map<String, dynamic> item =
                                userData.data() as Map<String, dynamic>;
                            print(userData.id);
                            return Card(
                              color: Colors.white,
                              elevation: 0,
                              child: ListTile(
                                onTap: () {
                                  var uid =
                                      FirebaseAuth.instance.currentUser?.uid ??
                                          "";

                                  var id = ((uid == item["receiverId"])
                                      ? item["senderId"]
                                      : item["receiverId"]);
                                  var email = ((uid == item["receiverId"])
                                      ? item["senderMail"]
                                      : item["receiverMail"]);
                                  Get.to(() => ChatRoom(), arguments: {
                                    "id": id,
                                    "email": email,
                                    "photo": user?.photoURL ?? ""
                                  });
                                  print("object  $uid ${item["receiverId"]}");
                                },
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.white),
                                  child: Image.network(user?.photoURL ?? "",
                                      fit: BoxFit.cover),
                                ),
                                title: Text("${item["receiverMail"]}"),
                                subtitle: Text("${item["message"]}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            );
                          },
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
