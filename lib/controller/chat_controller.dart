import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../model/userchat_model.dart';

class ChatController extends GetxController {
  String? senderId;
  RxString chatRoomId = "".obs;
  String? id;
  String? email;
  String? phone;
  int? index;
  String? name;
  String? photo;
  String? lastMsg;
  String? status;
  String? time;
  TextEditingController chatMessage = TextEditingController();
  RxInt cIndex = 0.obs;
  RxBool isTop = RxBool(false);
  var user = FirebaseAuth.instance.currentUser;

  @override
  void onInit() {
    super.onInit();

    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        isTop.value = scrollController.position.pixels == 0;
      } else {}
    });

    senderId = FirebaseAuth.instance.currentUser?.uid ?? "";
    if ((senderId?.isNotEmpty ?? true) && (chatRoomId.isEmpty)) {
      chatRoomId.value = "$senderId-$id";
    }

    FirebaseFirestore.instance
        .collection("chats")
        .doc(chatRoomId.value)
        .get()
        .then((value) => {
              if (!value.exists) {chatRoomId.value = "$id-$senderId"}
            });

    var args = Get.arguments;
    if (args != null) {
      id = args["id"];
      email = args["email"];
      photo = args["photo"];
      phone=args["phone"];
      lastMsg = args["lastMsg"];
    }

    FirebaseFirestore.instance
        .collection("chats")
        .doc(chatRoomId.value)
        .collection("messages")
        .get()
        .then((value) => {
              print(" sender data showm"),
            });
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

  void userChat( String receiverMail, String receiverId,
      String message, ) async {
    var srChat = await FirebaseFirestore.instance
        .collection("chats")
        .doc("$senderId-$receiverId")
        .get();

    if (!srChat.exists) {
      var srChat = await FirebaseFirestore.instance
          .collection("chats")
          .doc("$receiverId-$senderId")
          .get();
    }

    srChat.reference.set({

      "message": message,
      "senderId": senderId,
      "receiverId": receiverId,
      "senderMail": user?.email ?? "",
      "receiverMail": receiverMail,
    });

    srChat.reference.collection("messages").doc(DateTime.now().toString()).set(
          UserChat(
            time: "${DateTime.now().hour} :${DateTime.now().minute}",
            message: message,
            senderId: senderId,
            senderMail: user?.email??"",
          ).toJson(),
        );
  }
}
