// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:dating_app/controller/postmaker_controller.dart';
import 'package:dating_app/model/setting_detail_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostMaker extends StatelessWidget {
  final PostMakerController controller = Get.put(PostMakerController());

  PostMaker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.cancel_outlined,
              color: Colors.white,
            )),
        title: Text(
          "Add to Story",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height / 9,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: toolList.length,
              itemBuilder: (context, index) {
                var tool = toolList[index];
                var icon = tool["icon"];
                return Center(
                  child: InkWell(
                    onTap: () {
                      if(index==0) {
                        controller.pickImage(true);
                      } else if(index==1){
                        controller.pickMultiImage();
                      }else{
                        controller.pickVideo(false);
                      }
                    },
                    child: Container(
                      height: MediaQuery.sizeOf(context).height / 7,
                      width: MediaQuery.sizeOf(context).width / 3.7,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color(0xff344B4D),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                icon,
                                color: Colors.white,
                              )),
                          Text(
                            "${tool["name"]}",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height / 16,
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height / 5,
            width: MediaQuery.sizeOf(context).width,
            child: GridView.builder(
              itemCount: controller.imageFile?.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return Container(
                  height: MediaQuery.sizeOf(context).height/2,
                  width: MediaQuery.sizeOf(context).width,
                  child:
                      Image.file(File(controller.imageFile?[index].path ?? "")),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
