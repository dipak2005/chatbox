// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/controller/settingscontroller.dart';
import 'package:dating_app/model/setting_detail_util.dart';
import 'package:dating_app/view/home/home.dart';

import 'package:dating_app/view/home/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Settings extends StatelessWidget {
  final SettingsController controller = Get.put(SettingsController());

  Settings({super.key});

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(

        title: Text("Settings"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height / 50,
            ),
            Container(
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
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height / 60,
                  ),
                  StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("user")
                          .doc(user?.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        var data =
                            snapshot.data?.data() as Map<String, dynamic>?;
                        return ListTile(

                            onTap: () {

                              Get.to(()=>Profile(),arguments: data);
                            },
                            leading: Container(
                              height: 50,
                              width: 50,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30)),
                              child: CircleAvatar(
                                radius: 60,
                                child:
                                    ("${data?["image"]}").startsWith("https://")
                                        ? Image.network(
                                            ("${data?["image"]}"),
                                            fit: BoxFit.cover,
                                          )
                                        : Image.memory(
                                            base64Decode("${data?["image"]}"),
                                            fit: BoxFit.cover),
                              ),
                            ),
                            title: Text(
                              "${data?["name"]}",
                              style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.fontSize,
                                  fontWeight: FontWeight.w700),
                              
                            ),
                        subtitle: Text("${data?["lastMessage"]}"),);
                      }),
                  Expanded(
                    child: ListView.builder(
                      itemCount: settingList.length,
                      itemBuilder: (context, index) {
                        var data = settingList[index];
                        IconData icon = data["icon"];
                        return Card(
                          elevation: 0,
                          color: Theme.of(context).cardColor,
                          child: ListTile(
                            onTap: () {
                              Get.toNamed("${data["routeName"]}");
                            },
                            leading: CircleAvatar(
                              backgroundColor: Colors.lightGreen.shade50,
                              child: Icon(icon, color: Theme.of(context).primaryColorDark,),
                            ),
                            title: Text(
                              "${data["name"]}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.fontSize),
                            ),
                            subtitle: Text("${data["subName"]}",
                                style: TextStyle(
                                  fontSize: 13,
                                )),
                          ),
                        );
                      },
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
