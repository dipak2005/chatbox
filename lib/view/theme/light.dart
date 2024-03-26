// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

ThemeData light = ThemeData.light(useMaterial3: true).copyWith(
    colorScheme: const ColorScheme.light(background: Colors.green),
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(color: Colors.green,fontSize: 30)
    ),
    textTheme: const TextTheme(

        bodyMedium: TextStyle(
          // color: Colors.green,
          fontSize: 25,
          fontWeight: FontWeight.w700,
        ),

        displayMedium: TextStyle(
            color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500)),
    tabBarTheme: const TabBarTheme(
      indicatorColor: Colors.white,
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: Colors.white,
      unselectedLabelStyle: TextStyle(color: Colors.white60),
    ),
    iconTheme: const IconThemeData(color: Colors.white));
