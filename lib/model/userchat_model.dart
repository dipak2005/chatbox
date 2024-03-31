// To parse this JSON data, do
//
//     final userChat = userChatFromJson(jsonString);

import 'dart:convert';
import 'dart:ui';

UserChat userChatFromJson(String str) => UserChat.fromJson(json.decode(str));

String userChatToJson(UserChat data) => json.encode(data.toJson());

class UserChat {
  String? message;
  String? senderId;
  String? senderMail;
  DateTime? time;

  UserChat({
    this.message,
    this.senderId,
    this.senderMail,
    this.time,
  });

  factory UserChat.fromJson(Map<String, dynamic> json) => UserChat(
        message: json["message"],
        senderId: json["senderId"],
        senderMail: json["senderMail"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "senderId": senderId,
        "senderMail": senderMail,
        "time": time,
      };
}
