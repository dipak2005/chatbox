// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/controller/profileController.dart';
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
                  PopupMenuItem(child: Text("Share")),
                ];
              },
            )
          ],
        ),
        body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("user")
                .doc(user?.uid)
                .snapshots(),
            builder: (context, snapshot) {
              var data = snapshot.data?.data() as Map<String, dynamic>?;
              controller.photo = data?["image"];
              return Container(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: MediaQuery.sizeOf(context).height / 5.2,
                      width: MediaQuery.sizeOf(context).width / 2.2,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        child:  ("${data?["image"]}").startsWith("https://")
                            ? Image.network(
                          ("${data?["image"]}"),
                          fit: BoxFit.cover,
                        )
                            : Image.memory(base64Decode("${data?["image"]}"),
                            fit: BoxFit.cover)),
                    ),
                    Text(
                      "${data?["name"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize:
                            Theme.of(context).textTheme.displaySmall?.fontSize,
                      ),
                    ),
                    Text(
                      "+91 ${data?["phone"]}",
                      style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.bodyLarge?.fontSize),
                    ),
                  ],
                ),
              );
            }));
  }
}
