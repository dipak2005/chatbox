// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/model/login&signp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../model/userchat_model.dart';

class ChatController extends GetxController with WidgetsBindingObserver {
  String? senderId;
  RxString chatRoomId = "".obs;
  String? id;
  String? email;
  String? phone;
  int? index;
  RxString username = "".obs;
  String? photo;
  String? lastMsg;
 RxBool isClear=false.obs;
  RxBool status = false.obs;
  DateTime? time;
  RxBool isSend = false.obs;
  RxInt cIndex = 0.obs;
  RxBool isTop = RxBool(false);
  var user = FirebaseAuth.instance.currentUser;
  bool isToday = false;
  bool isYesterday = false;
  String image = "";
  var now = DateTime.now();
  var messageTime = DateFormat("HH:mm a");
  RxList<XFile> multiList = RxList<XFile>();
  RxBool isDelete = false.obs;

  Map<String, dynamic>? map = {};

  @override
  void onInit() {
    super.onInit();

    var args = Get.arguments;
    if (args != null) {
      id = args["id"];
      email = args["email"];
      photo = args["photo"];
      phone = args["phone"];
      lastMsg = args["lastMsg"];
      username.value = args["name"];
      // index=args["index"];
    }

    senderId = FirebaseAuth.instance.currentUser?.uid ?? "";

    chatRoomId.value = "$senderId-$id";

    WidgetsBinding.instance.addObserver(this);
    updateStatus(
        WidgetsBinding.instance.lifecycleState ?? AppLifecycleState.resumed);
  }

  void delete() {
    isDelete.value = true;
  }

  void updateStatus(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      status.value = true;
    } else {
      status.value = false;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update({"status": state == AppLifecycleState.resumed});
    super.didChangeAppLifecycleState(state);

    updateStatus(state);
  }

  String messageDateTile(DateTime dateTime) {
    if (DateTime.now().difference(dateTime).inDays == 0) {
      return "Today";
    } else if (DateTime.now().difference(dateTime).inDays == 1) {
      return "Yesterday";
    } else {
      return "";
      // return messageTime.format(now);
    }
  }

  void changeIndex(int index) {
    cIndex.value = index;
  }

  ScrollController scrollController = ScrollController(
    onAttach: (position) {},
  );

  void scrollUp() {
    double start = 0;
    scrollController.jumpTo(start);
  }

  void scrollDown() {
    double end = scrollController.position.maxScrollExtent;
    scrollController.jumpTo(end);
  }

  void deleteMessage(messageDate) {
    FirebaseFirestore.instance
        .collection("messages")
        .doc(messageDate)
        .delete()
        .then((value) => (value) {});
  }

  void userChat(String receiverMail, String receiverId, String message,
      String time, bool isRead,
      [image,receiverName]) async {
    var uChat = await FirebaseFirestore.instance
        .collection("chats")
        .doc("$senderId-$receiverId")
        .get();

    var rChat = await FirebaseFirestore.instance
        .collection("chats")
        .doc("$receiverId-$senderId")
        .get();

    var receiverData = await FirebaseFirestore.instance
        .collection("user")
        .doc(receiverId)
        .get();
    var receiverToken = receiverData.data()?["fcmToken"];

    sendFcmNotification(receiverToken, user?.displayName ?? "", message, image);

    /*
  *
  *  p-f
  *    msg =heynnn
  *     e=p$g.c
  *    si =f
  *    ri= f
  *  f-p
  *    msg =heynnn
  *     e=f@g.c
  *    si = f
  *    ri = p
  * */

    uChat.reference.set({
      "status": status.value,
      "message": message,
      "senderId": senderId,
      "receiverId": receiverId,
      "senderMail": user?.email ?? "",
      "receiverMail": receiverMail,
      "time": DateTime.now(),
      "isRead": false,
      "image": image,
      "email":user?.email,
      "name":user?.displayName??""
    });

    rChat.reference.set({
      "status": status.value,
      "message": message,
      "senderId": senderId,
      "receiverId": receiverId,
      "senderMail": user?.email ?? "",
      "receiverMail": receiverMail,
      "time": DateTime.now(),
      "isRead": false,
      "image": image,
      "email":receiverMail,
      "name":receiverName
    });

    uChat.reference.collection("messages").doc("${DateTime.now()}").set(
          UserChat(
                  // status: status,
                  time: DateTime.now(),
                  message: message,
                  senderId: senderId,
                  senderMail: user?.email ?? "",
                  isRead: false,
                  image: filepath.value)
              .toJson(),
        );

    rChat.reference.collection("messages").doc("${DateTime.now()}").set(
          UserChat(
                  // status: status,
                  time: DateTime.now(),
                  message: message,
                  senderId: senderId,
                  senderMail: user?.email ?? "",
                  isRead: false,
                  image: filepath.value)
              .toJson(),
        );
  }

  String formatDate(DateTime date) {
    // Format the date as needed
    if (time?.difference(date).inDays == 0) {
      return 'Today';
    } else if (time?.difference(date).inDays == 1) {
      return 'Yesterday';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  void sendFcmNotification(String receiverToken, String senderName,
      String message, String image) async {
    Map<String, dynamic> map = {
      "to": receiverToken,
      "notification": {"title": senderName, "body": message},
      "data": {"image": (image.isNotEmpty) ? image : ""}
    };

    var receiverDetails = await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        body: jsonEncode(map),
        headers: {
          "Content-Type": "application/json",
          "Authorization":
              "key=AAAA9rEsNB4:APA91bHqLMTSH7uGv8CXKVE1sh_FWBu2QZT2qVqpbK25wuneEvXh0FUq1sTrqDkBtr2akX4eiOqKQwstDMTfHi_ALVJDl4YzfFmzTD1P_QsiZ94E6Zxj_O9mp52_Xjm-J7hdmyRzIQ2b",
        });
  }

  void show() {
    (chatMessage.text.isEmpty) ? isSend.value = false : isSend.value;
  }

  RxString filepath = "".obs;

  Future<void> pickImage(bool isCamara) async {
    XFile? file = await ImagePicker()
        .pickImage(source: isCamara ? ImageSource.camera : ImageSource.gallery);
    filepath.value = file!.path;
  }

  Future<void> pickMedia(bool isCamera) async {
    XFile? file = await ImagePicker().pickMedia(
        maxHeight: MediaQuery.sizeOf(Get.context!).height / 1.6,
        imageQuality: 100,
        maxWidth: MediaQuery.sizeOf(Get.context!).width);
    filepath.value = file?.path ?? "";
  }

  Future<void> pickMultiple() async {
    List<XFile> file = await ImagePicker().pickMultiImage(
        maxWidth: MediaQuery.sizeOf(Get.context!).width, imageQuality: 100);
    multiList.value = file;
  }
}
