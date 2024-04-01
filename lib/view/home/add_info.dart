// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/controller/add_info_controller.dart';
import 'package:dating_app/controller/login_controller.dart';
import 'package:dating_app/controller/signup_controller.dart';
import 'package:dating_app/model/adduser_model.dart';
import 'package:dating_app/model/singleton_class/addUser_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/login&signp.dart';

class AddInfo extends StatelessWidget {
  final AddInfoConToLLer controller = Get.put(AddInfoConToLLer());

  AddInfo({super.key});

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Form(
          key: controller.editKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("user")
                        .doc(user?.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      var data = snapshot.data?.data() as Map<String, dynamic>?;
                      return CircleAvatar(
                        radius: 60,
                        child: Container(
                            height:
                            MediaQuery.sizeOf(context).height / 3.1,
                            width:
                            MediaQuery.sizeOf(context).width / 3.3,
                            margin: EdgeInsets.all(4),
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius:
                                BorderRadius.circular(100)),
                            child: ("${data?["image"]}").startsWith("https://")
                                ? Image.network(
                                    ("${data?["image"]}"),
                                   fit: BoxFit.cover,
                                  )
                                : Image.memory(
                                    base64Decode("${data?["image"]}"),
                                    fit: BoxFit.cover)),
                      );
                    }),
                TextButton(
                  onPressed: () {},
                  child: Text("Edit Picture"),
                ),
                Align(alignment: Alignment(-0.87, 0), child: Text("Name")),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: TextFormField(
                    onFieldSubmitted: (value) {},
                    controller: name,
                    validator: (value) {
                      if (value?.isEmpty ?? false) {
                        return "* Plz Enter Your Name";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: "Enter Your Username",
                      enabled: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.green)),
                      suffixIcon: Icon(Icons.edit, color: Colors.green),
                      hintStyle: TextStyle(color: Colors.green),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment(-0.87, 0),
                  child: Text(
                    "Phone Number",
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.bodyMedium?.fontSize,
                        color: Theme.of(context).textTheme.bodyMedium?.color),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: TextFormField(
                    onFieldSubmitted: (value) {},
                    controller: number,
                    validator: (value) {
                      if (value?.isEmpty ?? false) {
                        return "* Plz Enter Your Phone Number";
                      } else if (value?.length != 10) {
                        return "* Invalid Phone Number";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      prefix: Text("+91"),
                      hintText: "Enter Your Phone",
                      enabled: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.green)),
                      suffixIcon: Icon(Icons.mail, color: Colors.green),
                      hintStyle: TextStyle(color: Colors.green),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment(-0.87, 0),
                  child: Text(
                    "email",
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.bodyMedium?.fontSize,
                        color: Theme.of(context).textTheme.bodyMedium?.color),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: TextFormField(
                    onFieldSubmitted: (value) {},
                    controller: mail,
                    validator: (value) {
                      if (value?.isEmpty ?? false) {
                        return "* Plz Enter Your Email";
                      } else if (!isEmail(value ?? "")) {
                        return "* Invalid Email ";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Enter Your Email",
                      enabled: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.green)),
                      suffixIcon: Icon(Icons.mail, color: Colors.green),
                      hintStyle: TextStyle(color: Colors.green),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height / 18,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.green),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                    fixedSize: MaterialStatePropertyAll(
                      Size(MediaQuery.sizeOf(context).width / 2,
                          MediaQuery.sizeOf(context).height / 17),
                    ),
                  ),
                  onPressed: () async {
                    if (controller.editKey.currentState?.validate() ?? true) {
                      controller.editKey.currentState?.save();
                      AddUser(
                          image:
                              "https://as2.ftcdn.net/v2/jpg/05/89/93/27/500_F_589932782_vQAEAZhHnq1QCGu5ikwrYaQD0Mmurm0N.jpg",
                          phone: number.text,
                          email: mail.text,
                          name: name.text);
                      Get.showSnackbar(GetSnackBar(
                        icon: Image.asset("assets/splash.png"),
                        backgroundColor: Colors.green,
                        borderRadius: 15,
                        duration: Duration(seconds: 2),
                        title: "save",
                        message: "Successfully",
                      ));
                    }
                  },
                  child: Text(
                    "Save ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(p);

    return regExp.hasMatch(em);
  }
}
