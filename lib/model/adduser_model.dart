// To parse this JSON data, do
//
//     final addUser = addUserFromJson(jsonString);

import 'dart:convert';

AddUser addUserFromJson(String str) => AddUser.fromJson(json.decode(str));

String addUserToJson(AddUser data) => json.encode(data.toJson());

class AddUser {
  String? name;
  String? email;
  String? phone;
  String? status;
  String? lastMessage;
  String? lastTime;
  String? image;
  bool? online;

  AddUser({
    this.name,
    this.email,
    this.phone,
    this.status,
    this.lastMessage,
    this.lastTime,
    this.image,
    this.online,
  });

  factory AddUser.fromJson(Map<String, dynamic> json) => AddUser(
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    status: json["status"],
    lastMessage: json["lastMessage"],
    lastTime: json["lastTime"],
    image: json["image"],
    online: json["online"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "phone": phone,
    "status": status,
    "lastMessage": lastMessage,
    "lastTime": lastTime,
    "image": image,
    "online": online,
  };
}
