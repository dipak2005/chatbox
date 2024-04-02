// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/controller/drawer_controller.dart';
import 'package:dating_app/model/adduser_model.dart';
import 'package:dating_app/model/login&signp.dart';
import 'package:dating_app/view/home/docs/photobar.dart';
import 'package:dating_app/view/login/login.dart';
import 'package:dating_app/view/login/login1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DrawerApp extends StatelessWidget {
  final DrawersController controller = Get.put(DrawersController());

  DrawerApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return NavigationDrawer(
      children: [
        StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("user")
                .doc(user?.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError && snapshot.data != null) {
                return Text("Error ${snapshot.error}");
              } else if (snapshot.data != null && snapshot.hasData) {
                var data = snapshot.data?.data() as Map<String, dynamic>?;

                // var file = File(data?["image"]);
                // var readAsBytes = file.readAsBytes();
                // var img = base64Encode(readAsBytes);

                // var base64decode = base64Decode(img);

                // Uint8List? byte=;
                return UserAccountsDrawerHeader(
                  currentAccountPicture: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: MediaQuery.sizeOf(context).height / 3,
                              width: MediaQuery.sizeOf(context).width,
                              child: AlertDialog(
                                content: InkWell(
                                  onTap: () {
                                    Get.to(() => PhotoBar(), arguments: {
                                      "photo": data?["image"],
                                      "name": data?["name"],
                                    });
                                  },
                                  child: ("${data?["image"]}")
                                          .startsWith("https://")
                                      ? Image.network(
                                          ("${data?["image"]}"),
                                          fit: BoxFit.cover,
                                        )
                                      : Image.memory(
                                          base64Decode("${data?["image"]}"),
                                          fit: BoxFit.cover),
                                ),
                                actions: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.message_outlined,
                                        color: Colors.green),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.call_outlined,
                                        color: Colors.green),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.videocam_outlined,
                                        color: Colors.green),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.add, color: Colors.green),
                                  ),
                                ],
                                title: Text("${data?["name"]}",style: TextStyle(fontWeight: FontWeight.w700),),
                              ),
                            );
                          },
                        );
                      },
                      child: CircleAvatar(
                          child: ("${data?["image"]}").startsWith("https://")
                              ? Image.network(
                                  ("${data?["image"]}"),
                                  fit: BoxFit.cover,
                                )
                              : Image.memory(base64Decode("${data?["image"]}"),
                                  fit: BoxFit.cover)),
                    ),
                  ),
                  otherAccountsPictures: [
                    // CircleAvatar(
                    //   backgroundImage: (user?.photoURL==null)?MemoryImage(base64Decode(img)):Image(image: ),
                    // child: (user?.photoURL==null)?Image.memory(base64Decode(img)):Image.network(img),
                    // ),
                  ],
                  decoration: BoxDecoration(color: Colors.green.shade600),
                  accountName: Text(
                    "${data?["name"] ?? ""}",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  accountEmail: Text(
                    "${data?["email"] ?? ""}",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
        ListTile(
          onTap: () async {
            await FirebaseAuth.instance.signOut();
            await GoogleSignIn().signOut();
            Get.to(() => Login());
            filepath.value="";
          },
          title: Text(
            "Logout",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}
