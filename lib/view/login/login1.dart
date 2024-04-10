// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:dating_app/controller/login_controller.dart';
import 'package:dating_app/view/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/login&signp.dart';

class Login1 extends StatelessWidget {
  final LoginController controller = Get.find<LoginController>();

  Login1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: controller.gKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height / 6,
                ),
                Center(
                  child: Text(
                    "Log in to ChatBox",
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.headlineSmall?.fontSize,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height / 20,
                ),
                Text(
                    "Welcome back! Sign in using Your social\n         account or email to continue as"),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage("assets/face.png"),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () async {
                        controller.googleSignIn();
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 25,
                        backgroundImage: AssetImage("assets/google.png"),
                      ),
                    ),
                  ],
                ),
                Text(
                  "   ---------------------------- OR ------------------------------",
                  style: TextStyle(
                      fontWeight:
                          Theme.of(context).textTheme.bodySmall?.fontWeight,
                      color: Colors.black),
                ),
                Align(
                  alignment: Alignment(-0.8, 0),
                  child: Text(
                    "UserName",
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.bodyMedium?.fontSize,
                        color: Theme.of(context).textTheme.bodyMedium?.color),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value?.isEmpty ?? false) {
                        return "* Plz Enter Your Name";
                      } else {
                        return null;
                      }
                    },
                    controller: name,
                    onFieldSubmitted: (value) {},
                    decoration: InputDecoration(
                      hintText: "Enter Your Name",
                      enabled: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.green)),
                      suffixIcon: Icon(Icons.edit, color: Colors.green),
                      hintStyle: TextStyle(color: Colors.green),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(-0.8, 0),
                  child: Text(
                    "Your Email",
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.bodyMedium?.fontSize,
                        color: Theme.of(context).textTheme.bodyMedium?.color),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: TextFormField(
                    onFieldSubmitted: (value) {},
                    controller: mail,
                    validator: (value) {
                      if (value?.isEmpty ?? false) {
                        return "* Plz Enter Your Email";
                      } else if (!isEmail(value ?? "")) {
                        return "* Invalid Email ";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Enter Your Email",
                      enabled: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.green)),
                      suffixIcon: Icon(Icons.mail, color: Colors.green),
                      hintStyle: TextStyle(color: Colors.green),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(-0.8, 0),
                  child: Text(
                    "Password",
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.bodyMedium?.fontSize,
                        color: Theme.of(context).textTheme.bodyMedium?.color),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value?.isEmpty ?? false) {
                        return "Plz Enter Your Password";
                      } else {
                        return null;
                      }
                    },
                    controller: password,
                    decoration: InputDecoration(
                      hintText: "Enter Your Password",
                      enabled: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.green)),
                      suffixIcon:
                          Icon(Icons.password_outlined, color: Colors.green),
                      hintStyle: TextStyle(color: Colors.green),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height / 10,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.green),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11))),
                    fixedSize: MaterialStatePropertyAll(
                      Size(MediaQuery.sizeOf(context).width / 1.1,
                          MediaQuery.sizeOf(context).height / 17),
                    ),
                  ),
                  onPressed: () async {
                    if (controller.gKey.currentState?.validate() ?? true) {
                      try {
                        UserCredential user = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: mail.text, password: password.text);

                        User? userDetail = user.user;
                        if (userDetail != null) {
                          await userDetail.updateEmail(mail.text);
                          await userDetail.updatePassword(password.text);
                          await userDetail.updateDisplayName(name.text);

                          Get.off(() => Home());
                        }
                      } on FirebaseAuthException catch (e) {
                        print(e.message);
                      }
                    }
                  },
                  child: Text(
                    "Log in",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    controller.goPassword();
                  },
                  child: Text(
                    "Forget Password?",
                    style: TextStyle(color: Colors.green),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(p);

    return regExp.hasMatch(em);
  }
}
