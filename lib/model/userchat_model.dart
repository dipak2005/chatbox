// To parse this JSON data, do
//
//     final userChat = userChatFromJson(jsonString);

import 'dart:convert';

UserChat userChatFromJson(String str) => UserChat.fromJson(json.decode(str));

String userChatToJson(UserChat data) => json.encode(data.toJson());

class UserChat {
  String? message;
  String? senderId;
  String? senderMail;
  DateTime? time;
  bool isRead=false;
  String image="";
  UserChat(
      {this.message, this.senderId, this.senderMail, this.time, required this.isRead,  required this.image});

  factory UserChat.fromJson(Map<String, dynamic> json) => UserChat(
      message: json["message"],
      senderId: json["senderId"],
      senderMail: json["senderMail"],
      time: json["time"],
      isRead: json["isRead"],
      image: json["image"],
  );

  Map<String, dynamic> toJson() => {
        "message": message,
        "senderId": senderId,
        "senderMail": senderMail,
        "time": time,
        "isRead": isRead,
    "image":image
      };
}
