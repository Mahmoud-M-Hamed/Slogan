import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:slogan/styles/colors.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: mainColor,
  primaryColor: mainColor,
  scaffoldBackgroundColor: Colors.white,
  iconTheme: const IconThemeData(color: mainColor).copyWith(color: mainColor),
  textTheme: const TextTheme(bodyLarge: TextStyle(fontWeight: FontWeight.bold)),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(
      color: mainColor,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      fontSize: 40,
    ),
    iconTheme: IconThemeData(color: mainColor),
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white),
  ),
);
