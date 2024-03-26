// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dating_app/controller/settingscontroller.dart';
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
        leading:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 20,
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios,
              ),
            ),
          ),
        ),
        title: Text("Settings"),centerTitle: true,
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
        child: Column(
          children: [
            ListTile(onTap:() => controller.goProfile(),
              leading:
                  Icon(Icons.person, color: Theme.of(context).primaryColorDark),
              title: Text("View Profile",
                  style: Theme.of(context).textTheme.headlineSmall),
              trailing: IconButton(
                onPressed: () {
                  controller.goProfile();
                },
                icon: Icon(Icons.arrow_forward_ios),
              ),
            ),
            Obx(
            ()=> ListTile(
                leading: Icon(Icons.dark_mode,
                    color: Theme.of(context).primaryColorDark),
                title: Text(
               "DarkMode",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                trailing: SizedBox(
                  width: 120,
                  child: CupertinoSwitch(
                    value: controller.isDark.value,
                    onChanged: (value) {
                      controller.changeTheme(value);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
