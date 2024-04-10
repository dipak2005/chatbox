// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dating_app/controller/chat_controller.dart';
import 'package:dating_app/controller/content_controller.dart';
import 'package:dating_app/model/login&signp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Content extends StatelessWidget {
  final ContentController controller = Get.put(ContentController());
  ChatController chat = Get.find<ChatController>();

  Content({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Scaffold(
          appBar: AppBar(
            title: Text("Share a Content",
                style: TextStyle(fontWeight: FontWeight.w500)),
            centerTitle: true,
          ),
          body: ListView(
            children: [
              Card(
                color: Theme.of(context).cardColor,
                elevation: 0,
                child: ListTile(
                  onTap: () async {
                    if (controller.filepath.value.isEmpty) {
                      await chat.pickImage(true);
                      chat.userChat(
                          chat.email ?? "",
                          chat.id ?? "",
                          chatMessage.text,
                          DateTime.now().toString(),
                          false,
                          chat.filepath.value);
                      // await  Get.to(()=>ChatRoom());
                    }
                  },
                  leading: CircleAvatar(
                    backgroundColor: Colors.lightGreen.shade50,
                    child: IconButton(
                        onPressed: () async{
                          if (controller.filepath.value.isEmpty) {
                            await chat.pickImage(true);
                            chat.userChat(
                                chat.email ?? "",
                                chat.id ?? "",
                                chatMessage.text,
                                DateTime.now().toString(),
                                false,
                                chat.filepath.value);
                            // await  Get.to(()=>ChatRoom());
                          }
                        },
                        icon: Icon(
                          Icons.camera_alt_outlined,
                          color: Theme.of(context).primaryColorDark,
                        )),
                  ),
                  title: Text(
                    "Camera",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize:
                            Theme.of(context).textTheme.titleMedium?.fontSize),
                  ),
                ),
              ),
              Card(
                color: Theme.of(context).cardColor,
                elevation: 0,
                child: ListTile(
                  onTap: () async{
                    if (controller.filepath.value.isEmpty) {
                      await chat.pickMedia(true);
                      chat.userChat(
                          chat.email ?? "",
                          chat.id ?? "",
                          chatMessage.text,
                          DateTime.now().toString(),
                          false,
                          chat.filepath.value);
                      // await  Get.to(()=>ChatRoom());
                    }
                  },
                  leading: CircleAvatar(
                    backgroundColor: Colors.lightGreen.shade50,
                    child: IconButton(
                        onPressed: ()async {
                          if (controller.filepath.value.isEmpty) {
                            await chat.pickMedia(true);
                            chat.userChat(
                                chat.email ?? "",
                                chat.id ?? "",
                                chatMessage.text,
                                DateTime.now().toString(),
                                false,
                                chat.filepath.value);
                            // await  Get.to(()=>ChatRoom());
                          }
                        },
                        icon: Icon(
                          Icons.file_copy_outlined,
                          color: Theme.of(context).primaryColorDark,
                        )),
                  ),
                  title: Text(
                    "Documents",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize:
                            Theme.of(context).textTheme.titleMedium?.fontSize),
                  ),
                  subtitle: Text("Share Your files",
                      style: TextStyle(
                        fontSize: 13,
                      )),
                ),
              ),
              Card(
                color: Theme.of(context).cardColor,
                elevation: 0,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.lightGreen.shade50,
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.poll_outlined,
                          color: Theme.of(context).primaryColorDark,
                        )),
                  ),
                  title: Text(
                    "Create a poll",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize:
                            Theme.of(context).textTheme.titleMedium?.fontSize),
                  ),
                  subtitle: Text("Create a poll for any Query",
                      style: TextStyle(
                        fontSize: 13,
                      )),
                ),
              ),
              Card(
                color: Theme.of(context).cardColor,
                elevation: 0,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.lightGreen.shade50,
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.person_pin,
                          color: Theme.of(context).primaryColorDark,
                        )),
                  ),
                  title: Text(
                    "Contact",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize:
                            Theme.of(context).textTheme.titleMedium?.fontSize),
                  ),
                  subtitle: Text("Share your contacts",
                      style: TextStyle(
                        fontSize: 13,
                      )),
                ),
              ),
              Card(
                color: Theme.of(context).cardColor,
                elevation: 0,
                child: ListTile(
                  onTap: () async{
                    if (controller.filepath.value.isEmpty) {
                      await chat.pickMedia(true);
                      chat.userChat(
                          chat.email ?? "",
                          chat.id ?? "",
                          chatMessage.text,
                          DateTime.now().toString(),
                          false,
                          chat.filepath.value);
                      // await  Get.to(()=>ChatRoom());
                    }
                  },
                  leading: CircleAvatar(
                    backgroundColor: Colors.lightGreen.shade50,
                    child: IconButton(
                        onPressed: ()async {
                          if (controller.filepath.value.isEmpty) {
                            await chat.pickMedia(true);
                            chat.userChat(
                                chat.email ?? "",
                                chat.id ?? "",
                                chatMessage.text,
                                DateTime.now().toString(),
                                false,
                                chat.filepath.value);
                            // await  Get.to(()=>ChatRoom());
                          }

                        },
                        icon: Icon(
                          Icons.perm_media_outlined,
                          color: Theme.of(context).primaryColorDark,
                        )),
                  ),
                  title: Text(
                    "Media",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize:
                            Theme.of(context).textTheme.titleMedium?.fontSize),
                  ),
                  subtitle: Text("Share photos and videos",
                      style: TextStyle(
                        fontSize: 13,
                      )),
                ),
              ),
              Card(
                color: Theme.of(context).cardColor,
                elevation: 0,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.lightGreen.shade50,
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.location_on_outlined,
                          color: Theme.of(context).primaryColorDark,
                        )),
                  ),
                  title: Text(
                    "Location",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize:
                            Theme.of(context).textTheme.titleMedium?.fontSize),
                  ),
                  subtitle: Text(
                    "Share your Location",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
