// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:typed_data';

import 'package:dating_app/model/userchat_model.dart';
import 'package:dating_app/view/home/add_info.dart';
import 'package:dating_app/view/home/docs/account.dart';
import 'package:dating_app/view/home/docs/chat_settings.dart';
import 'package:dating_app/view/home/docs/help.dart';
import 'package:dating_app/view/home/docs/notifications.dart';
import 'package:dating_app/view/home/docs/post_maker.dart';
import 'package:dating_app/view/home/docs/post_viewer.dart';



import 'package:dating_app/view/home/home.dart';
import 'package:dating_app/view/home/pages/chat_room.dart';
import 'package:dating_app/view/home/pages/contact.dart';
import 'package:dating_app/view/home/pages/image.dart';
import 'package:dating_app/view/home/profile.dart';
import 'package:dating_app/view/home/splash.dart';
import 'package:dating_app/view/login/forgetpassword.dart';
import 'package:dating_app/view/login/login.dart';
import 'package:dating_app/view/login/login1.dart';
import 'package:dating_app/view/login/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:http/http.dart' as http;

import 'firebase_options.dart';
import 'model/login&signp.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

AndroidNotificationChannel channel = AndroidNotificationChannel(
  "ChatBox",
  "ChatBox",
  importance: Importance.high,
  description: "This Channel is user for very important notifications",
  playSound: true,
  enableVibration: true,
);

bool isFlutterNotificationInitialized = false;


@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage remoteMessage) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showLocalNotification(remoteMessage);
  print('Handling a background message ${remoteMessage.messageId}');
}


Future<void> setupFlutterNotifications() async {
  if (isFlutterNotificationInitialized) {
    return;
  }

  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    sound: true,
    alert: true,
    badge: true,
  );
  isFlutterNotificationInitialized = true;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  InitializationSettings settings =
      InitializationSettings(android: AndroidInitializationSettings("ic_chat"));

  await flutterLocalNotificationsPlugin.initialize(settings);
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();

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
      initialRoute: user == null ? "/" : "splash",
      routes: {
        "/": (p0) => Login(),
        "log1": (p0) => Login1(),
        "image": (p0) => UserImage(),
        "signup": (p0) => Signup(),
        "password": (p0) => ForgetPassword(),
        "splash": (p0) => Splash(),
        "home": (p0) => Home(),
        "profile": (p0) => Profile(),
        "add_info": (p0) => AddInfo(),
        "contacts": (p0) => Contacts(),
        "chat": (p0) => ChatRoom(),
        "account":(p0) => Account(),
        "chat_settings":(p0) => ChatSettings(),
        "notify":(p0) => Notifications(),
        "help":(p0) => Help(),
        "postMaker":(p0) => PostViewer(),
        "postViewer":(p0) => PostMaker(),
      },
    );
  }
}



Future<Uint8List> getByteArrayFromUrl(String url) async {
  final http.Response response = await http.get(Uri.parse(url));
  return response.bodyBytes;
}
void showLocalNotification([RemoteMessage? remoteMessage]) async {
  // var image = remoteMessage?.data["image"];

  final ByteArrayAndroidBitmap largeIcon =
  ByteArrayAndroidBitmap(await getByteArrayFromUrl("https://miro.medium.com/v2/resize:fit:1200/1*0ydORE9FJGp_8REX-oRArQ.png"));

  flutterLocalNotificationsPlugin.show(
      0,
      remoteMessage?.notification?.title ?? "",
      remoteMessage?.notification?.body ?? "",
      NotificationDetails(
        android: AndroidNotificationDetails(
          "ChatBox",
          "ChatBox",
          category: AndroidNotificationCategory.locationSharing,
          priority: Priority.max,
          channelDescription: "ChatBox",
          visibility: NotificationVisibility.public,
          importance: Importance.max,
          styleInformation: BigPictureStyleInformation(
            largeIcon,
           contentTitle: chatMessage.text
          ),
        ),
      ));
}
