// ignore_for_file: prefer_const_constructors

import 'package:dating_app/model/login&signp.dart';
import 'package:dating_app/model/setting_detail_util.dart';
import 'package:dating_app/view/home/docs/photobar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WallPaper extends StatelessWidget {
  const WallPaper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Set as WallPaper"),
      ),
      body: GridView.builder(
        itemCount: imageList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          var image=imageList[index];
          return Container(
            height: MediaQuery.sizeOf(context).height/4,
            width: MediaQuery.sizeOf(context).width/2,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular( 20),
              
            ),margin: EdgeInsets.all(10),
            child:InkWell(
                onTap: () {
               Get.to(()=>PhotoBar(),arguments: {
                 "image":image,
                 "name":"wallpaper",
                 "index":index,
               });
                },
                child: Image.asset(image,fit: BoxFit.fitWidth)) ,
          );
        },
      ),
    );
  }
}
