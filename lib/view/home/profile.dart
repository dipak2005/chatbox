// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/controller/profileController.dart';
import 'package:dating_app/model/login&signp.dart';
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
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("user").snapshots(),
          builder: (context, snapshot) {
            var data = snapshot.data?.docs ?? [];
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                var userData = data[index].data() as Map<String, dynamic>;
                controller.photo = ((user?.photoURL != null)
                    ? user?.photoURL ?? ""
                    : userData["image"]);
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
                        child: Image.network(
                            ((user?.photoURL != null)
                                ? user?.photoURL ?? ""
                                : userData["image"]),
                            fit: BoxFit.cover),
                      ),
                      Text(
                        ((user?.displayName ?? "").isNotEmpty)
                            ? user?.displayName ?? ""
                            : userData["name"],
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.fontSize,
                        ),
                      ),
                      Text(
                        "+91 ${userData["phone"]}",
                        style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.fontSize),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
    );
  }
}
