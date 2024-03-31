

// ignore_for_file: prefer_const_constructors

import 'package:dating_app/view/home/docs/account.dart';
import 'package:dating_app/view/home/docs/chat_settings.dart';
import 'package:dating_app/view/home/docs/help.dart';
import 'package:dating_app/view/home/docs/notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

List<Map<String,dynamic>> settingList=[
  {
    "icon":Icons.key,
    "name":"Account",
    "subName":"Privacy,security,change Number",
    "routeName":"account",
    "index":"0",
  },
  {
    "icon":Icons.message,
    "name":"Chat",
    "subName":"Chat history,theme,wallpapers ",
    "routeName":"chat_settings",
    "index":"1",
  },
  {
    "icon":Icons.notifications_active_outlined,
    "name":"Notifications",
    "subName":"Messages,groups and other",
    "routeName":"notify",
    "index":"2",
  },
  {
    "icon":Icons.help_outline,
    "name":"Help",
    "subName":"Help center,contact us privacy policy",
    "routeName":"help",
    "index":"3",
  }

];


List<Map<String,dynamic>> toolList=[
  {
    "icon":Icons.camera,
    "name":"Camera"
  },
  {
    "icon":Icons.photo_outlined,
    "name":"Photos"
  },
  {
    "icon":Icons.play_circle_outline_rounded,
    "name":"Videos"
  }
];