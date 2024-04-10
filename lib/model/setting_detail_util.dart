// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

List<Map<String, dynamic>> settingList = [
  {
    "icon": Icons.message,
    "name": "Chat",
    "subName": "Chat history,theme,wallpapers ",
    "routeName": "chat_settings",
    "index": "1",
  },
  {
    "icon": Icons.notifications_active_outlined,
    "name": "Notifications",
    "subName": "Messages,groups and other",
    "routeName": "notify",
    "index": "2",
  },
  {
    "icon": Icons.help_outline,
    "name": "Help",
    "subName": "Help center,contact us privacy policy",
    "routeName": "help",
    "index": "3",
  }
];

List<Map<String, dynamic>> toolList = [
  {"icon": Icons.camera, "name": "Camera"},
  {"icon": Icons.photo_outlined, "name": "Photos"},
  {"icon": Icons.play_circle_outline_rounded, "name": "Videos"}
];

List<String> imageList = [
  "assets/back3.jpg",
  "assets/image1.jpg",
  "assets/image2.jpeg",
  "assets/images3.jpg",
  "assets/images4.jpeg",
  "assets/image5.jpeg",
  "assets/image6.jpg",
  "assets/image7.jpg",
];
