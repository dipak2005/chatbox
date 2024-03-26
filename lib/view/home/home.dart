// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:dating_app/controller/homecontroller.dart';
import 'package:dating_app/view/home/pages/contact.dart';
import 'package:dating_app/view/home/pages/call.dart';
import 'package:dating_app/view/home/pages/drawer.dart';
import 'package:dating_app/view/home/pages/message.dart';
import 'package:dating_app/view/home/pages/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  HomeController controller = Get.put(HomeController());

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      // appBar: AppBar(
      //   title: Obx(
      //     ()=> Text(
      // (controller.pIndex.value==0)?"Home":(controller.pIndex.value==1)?"Contacts":(controller.pIndex.value==2)?"Calls":"Settings",
      //       style: TextStyle(
      //           fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
      //           color: Theme.of(context).textTheme.displayMedium?.color),
      //     ),
      //   ),
      //   centerTitle: true,

      // ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => IndexedStack(
                  index: controller.pIndex.value,
                  children: [
                    Message(),
                    Contacts(),
                    Calls(),
                    Settings(),
                  ],
                ),
              ),
            ),
            Obx(
              () => BottomNavigationBar(
                type: BottomNavigationBarType.shifting,
                currentIndex: controller.pIndex.value,
                onTap: (value) {
                  controller.changeIndex(value);
                  print("object$value");
                },
                backgroundColor: Colors.white,
                elevation: 10,
                unselectedFontSize: 15,
                selectedFontSize: 17,
                selectedItemColor: Colors.green,
                // unselectedLabelStyle: TextStyle(color: Colors.black),
                unselectedItemColor: Colors.black,
                selectedIconTheme: IconThemeData(color: Colors.green),
                unselectedIconTheme: IconThemeData(color: Colors.grey),
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.messenger_outline),
                    label: "Chats",
                    activeIcon: Hero(
                      tag: controller.pIndex.value,
                      child: Icon(
                        Icons.messenger,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.person_3),
                    label: "Contact",
                    activeIcon: Hero(
                      tag: controller.pIndex.value,
                      child: Icon(
                        CupertinoIcons.person_3_fill,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.phone_arrow_up_right),
                      activeIcon: Hero(
                          tag: controller.pIndex.value,
                          child:
                              Icon(CupertinoIcons.phone_fill_arrow_up_right)),
                      label: "Calls"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings_suggest_outlined),
                      activeIcon: Hero(
                          tag: controller.pIndex.value,
                          child: Icon(Icons.settings_suggest)),
                      label: "Settings"),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}
