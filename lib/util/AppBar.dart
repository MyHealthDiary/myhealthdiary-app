import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

AppBar makeAppBar(String title) {
  return AppBar(
      textTheme: TextTheme(
          headline6: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.normal)),
      title: Text(title, textAlign: TextAlign.center),
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Color(0xff6d9eeb),
      elevation: 0);
}