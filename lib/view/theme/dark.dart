import 'package:flutter/material.dart';

ThemeData Dark = ThemeData.light(
  useMaterial3: true,
).copyWith(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.light(background: Colors.green),
);
