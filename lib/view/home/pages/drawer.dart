// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/model/adduser_model.dart';
import 'package:dating_app/view/login/login.dart';
import 'package:dating_app/view/login/login1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DrawerApp extends StatelessWidget {
  const DrawerApp({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return NavigationDrawer(
      children: [
        UserAccountsDrawerHeader(
          currentAccountPicture: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
              ),
              child: (user?.photoURL?.isNotEmpty ?? false)
                  ? CircleAvatar(child: Image.network(user?.photoURL ?? ""))
                  : CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Image.asset(
                        "assets/profile.png",
                        fit: BoxFit.cover,
                      ))),
          decoration: BoxDecoration(color: Colors.green.shade600),
          accountName: Text(
            user?.displayName ?? "",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          accountEmail: Text(
            user?.email ?? "",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        ListTile(
          onTap: () async {
            await FirebaseAuth.instance.signOut();
            await GoogleSignIn().signOut();
            Get.to(() => Login());
          },
          title: Text(
            "Logout",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w700),
          ),
        ),
        IconButton(
            onPressed: () async {
              // FirebaseFirestore.instance
              //     .collection("user")
              //     .doc(FirebaseAuth.instance.currentUser?.uid ?? "").update();
            },
            icon: Icon(Icons.add)),
      ],
    );
  }
}
