import 'package:flutter/material.dart';

class SettingListModel{
  String? name;
  String? subName;
  IconData? icon;
  String? routeName;
  String? index;

  SettingListModel(
      {this.name, this.subName, this.icon, this.routeName, this.index});


  factory SettingListModel.fromMap(Map<String,dynamic> map){
    return SettingListModel(
      name: map["name"],
      icon: map["icon"],
        index: map["index"],
      routeName: map["routeName"],
      subName: map["subName"]
    );
  }



}