// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'dart:convert';
import 'dart:io';

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
    var user = FirebaseAuth.instance.currentUser;
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height / 50,
            ),
            Container(
              height: MediaQuery.sizeOf(context).height / 0.9,
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
                    .collection("user")
                    .where("email",
                        isNotEqualTo: FirebaseAuth.instance.currentUser?.email)
                    .snapshots(),
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
                          var photo =
                              ("${userdata["image"]}").startsWith("https://")
                                  ? ("${userdata["image"]}")
                                  : ("${userdata["image"]}")
                                      .replaceAll('-', '+')
                                      .replaceAll('-', '/');
                          var lastMsg = userdata["LastMessage"];

                          Get.to(() => ChatRoom(), arguments: {
                            "email": email,
                            "id": item.id,
                            "phone": phone,
                            "name": username,
                            "photo": photo,
                            "lastMsg": lastMsg,
                          });
                        },
                        leading: Container(
                          height: 50,
                          width: 50,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30)),
                          child: CircleAvatar(
                              radius: 50,
                              child: ("${userdata["image"]}")
                                      .startsWith("https://")
                                  ? Image.network(
                                      ("${userdata["image"]}"),
                                      fit: BoxFit.cover,
                                    )
                                  : Image.memory(
                                      base64Decode("${userdata["image"]}"),
                                      fit: BoxFit.cover)),
                        ),
                        title: Text("${userdata["name"]}"),
                        subtitle: Text("${userdata["email"]}"),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
