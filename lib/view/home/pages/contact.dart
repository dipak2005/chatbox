// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/controller/chat_controller.dart';
import 'package:dating_app/controller/contact_controller.dart';
import 'package:dating_app/model/login&signp.dart';
import 'package:dating_app/view/home/pages/chat_room.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Contacts extends StatelessWidget {
  final ContactController controller = Get.put(ContactController());

  Contacts({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 20,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.search,
              ),
            ),
          ),
        ),
        title: Text("Select Contacts"),
        actions: [
          CircleAvatar(
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  CupertinoIcons.person_add_solid,
                )),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("user").snapshots(),
        builder: (context, snapshot) {
          var data = snapshot.data?.docs ?? [];
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              var item = data[index];
              var userdata = item.data() as Map<String, dynamic>;

              return ListTile(
                onTap: () {
                  var email = userdata["email"];
                  var phone = userdata["number"];
                  var username = userdata["name"];
                  var photo = userdata["image"];
                  var lastMsg = userdata["LastMessage"];
                  Get.to(() => ChatRoom(), arguments: {
                    "email": email,
                    "id": item.id,
                    "phone": phone,
                    "name": name,
                    "photo": photo,
                    "lastMsg": lastMsg,
                  });
                },
                leading: Container(
                  height: 50,
                  width: 50,
                  clipBehavior: Clip.antiAlias,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(30)),
                  child:
                      Image.network("${userdata["image"]}", fit: BoxFit.cover),
                ),
                title: Text("${userdata["email"]}"),
                subtitle: Text("${userdata["name"]}"),
              );
            },
          );
        },
      ),
    );
  }
}
