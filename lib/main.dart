// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dating_app/model/userchat_model.dart';
import 'package:dating_app/view/home/add_info.dart';
import 'package:dating_app/view/home/home.dart';
import 'package:dating_app/view/home/pages/chat_room.dart';
import 'package:dating_app/view/home/pages/contact.dart';
import 'package:dating_app/view/home/profile.dart';
import 'package:dating_app/view/home/splash.dart';
import 'package:dating_app/view/login/forgetpassword.dart';
import 'package:dating_app/view/login/login.dart';
import 'package:dating_app/view/login/login1.dart';
import 'package:dating_app/view/login/signup.dart';
import 'package:dating_app/view/theme/dark.dart';
import 'package:dating_app/view/theme/light.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return GetMaterialApp(
      title: "Unboxing Your Date",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      // themeMode: Get.isDarkMode?ThemeMode.dark:ThemeMode.light,
      initialRoute: "/",
      // home: user != null ? Home() : Login(),
      routes: {
        "/": (p0) => Splash(),
        "login": (p0) => Login(),
        "log1": (p0) => Login1(),
        "signup": (p0) => Signup(),
        "password": (p0) => ForgetPassword(),
        "home": (p0) => Home(),
        "profile": (p0) => Profile(),
        "add_info": (p0) => AddInfo(),
        "contacts":(p0) => Contacts(),
        "chat":(p0) => ChatRoom(),
      },
    );
  }
}
