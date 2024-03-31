// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Calls extends StatelessWidget {
  const Calls({super.key});

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
          title: Text("Calls"),
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
                          isNotEqualTo:
                              FirebaseAuth.instance.currentUser?.email)
                      .snapshots(),
                  builder: (context, snapshot) {
                    var data = snapshot.data?.docs ?? [];
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        var item = data[index];
                        var userdata = item.data() as Map<String, dynamic>;

                        return ListTile(
                          onLongPress: () {},
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
                          subtitle: Text("${userdata["lastTime"]}"),
                          trailing: SizedBox(
                            width: MediaQuery.sizeOf(context).width / 3.4,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    // var phone = Uri.parse("whatsapp: +91${controller.phone}");
                                    // launchUrl(phone);
                                    // print("object");
                                  },
                                  icon: Icon(Icons.phone_in_talk_outlined),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.videocam_outlined),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
