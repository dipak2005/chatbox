// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dating_app/controller/settingscontroller.dart';
import 'package:dating_app/view/home/docs/media.dart';
import 'package:dating_app/view/home/docs/wallpaper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../controller/profileController.dart';

class ChatSettings extends StatelessWidget {
  final SettingsController controller = Get.find<SettingsController>();

  ChatSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chats",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment(-0.8, 0),
            child: Text(
              "Display",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: Theme.of(context).textTheme.titleSmall?.fontSize),
            ),
          ),
          Obx(
            () => ListTile(
              leading: Icon(Icons.dark_mode,
                  color: Theme.of(context).primaryColorDark),
              title: Text(
                "Theme",
                style: TextStyle(
                    fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                    fontWeight: FontWeight.w700),
              ),
              subtitle: Text(
                (controller.isDark.value != true) ? "Light" : "Dark",
                style: TextStyle(fontWeight: FontWeight.w500),
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
          ),
          ListTile(
            onTap: () {
              Get.to(() => WallPaper());
            },
            leading: Icon(Icons.wallpaper_outlined),
            title: Text(
              "Wallpaper",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: Theme.of(context).textTheme.titleSmall?.fontSize),
            ),
          ),
        ],
      ),
    );
  }
}
