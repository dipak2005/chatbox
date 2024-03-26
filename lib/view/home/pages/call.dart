// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Calls extends StatelessWidget {
  const Calls({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 20,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.search,
              ),
            ),
          ),
        ),
        title: Text("Calls"),
        actions: [
          CircleAvatar(
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  CupertinoIcons.person_add_solid,
                )),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (context, snapshot) {
          var data=snapshot.data?.docs??[];
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
            QueryDocumentSnapshot userData=  data[index];
             Map<String,dynamic> user=userData.data() as Map<String,dynamic>;
          return ListTile(
            title: Text("${user["mail"]}"),
          );
            },
          );
        },
      ),
    );
  }
}
