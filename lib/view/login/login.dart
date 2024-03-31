// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dating_app/controller/login_controller.dart';
import 'package:dating_app/view/home/pages/image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xff1A1A1A),
            Color(0xff1D1920),
            Color(0xff271736),
            Color(0xff261635),
            Color(0xff2F1547),
            Color(0xff24172F),
            Color(0xff1B1A1B),
            Color(0xff1B1A1B),
            Color(0xff1A1A1A),
            Color(0xff1B1A1B),
            Color(0xff1A1A1A),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset("assets/logo.png"),
              Align(
                  alignment: Alignment(-0.5, 0),
                  child: Image.asset("assets/text.png")),
              Align(
                  alignment: Alignment(-0.5, 0),
                  child: Image.asset("assets/text1.png")),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    radius: 35,
                    child: InkWell(
                      onTap: () {},
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage("assets/face.png"),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    radius: 35,
                    child: InkWell(
                      onTap: ()  {
                        controller.googleSignIn();
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 25,
                        backgroundImage: AssetImage("assets/google.png"),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                "---------------------------------- OR --------------------------------",
                style: TextStyle(
                    fontWeight:
                        Theme.of(context).textTheme.bodySmall?.fontWeight,
                    color: Colors.white),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    elevation: MaterialStatePropertyAll(4),
                    fixedSize: MaterialStatePropertyAll(Size(
                        MediaQuery.sizeOf(context).width / 1.2,
                        MediaQuery.sizeOf(context).height / 15))),
                onPressed: () {
                  Get.to(()=>UserImage());

                },
                child: Text(
                  "Sign up with mail ",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                ),
              ),
              TextButton(
                  onPressed: () {
                    controller.goto();
                  },
                  child: Text(
                    "Existing account? Log in",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
