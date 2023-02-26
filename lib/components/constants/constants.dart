import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:slogan/moduels/slogan/signin_activity/signin_activity.dart';
import 'package:slogan/shared_helper/sharedpreferences_helper/sharedpreferences.dart';

const String mainTitle = "Slogan";
dynamic token;

// ignore: constant_identifier_names
enum ToastStates { SUCCESS, ERROR }

Color? toastColor(ToastStates toastStates) {
  Color? backgroundToastColor;
  switch (toastStates) {
    case ToastStates.SUCCESS:
      backgroundToastColor = Colors.green;
      break;
    case ToastStates.ERROR:
      backgroundToastColor = Colors.red;
      break;
  }

  return backgroundToastColor;
}

showToast({required String? message, required ToastStates? toastStates}) {
  return Fluttertoast.showToast(
      msg: message!,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: toastColor(toastStates!),
      textColor: Colors.white,
      fontSize: 16.0);
}

void signOutMethod(context) {
  SharedPreferenceHelper.removeData(key: "token").then((value) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => SignInActivity()));
  });
}
