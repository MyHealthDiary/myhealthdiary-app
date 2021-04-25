import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myhealthdiary/server/User.dart';
import 'package:myhealthdiary/wsInterface.dart';
import 'package:myhealthdiary/SessionManager.dart';

import '../LoginData.dart';

class SplashScreen extends StatefulWidget {
  final wsInterface wsinterface;
  int duration = 1;

  SplashScreen(this.wsinterface);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  SessionManager sessionManager = SessionManager();

  @override
  void initState() {
    super.initState();
    asyncInit();
  }

  void asyncInit() async {
    await sessionManager.init();
    await widget.wsinterface.init();
    Timer(Duration(seconds: 2), () async {
      if (sessionManager.isUserLogged()) {
        // LoginData email = await sessionManager.getLoggedUser();
        //User user = await widget.wsinterface.findUserByEmail(email);
        //bool loggedUser = await widget.wsinterface.doLogin(user.email, user.password);
        //if (loggedUser){
        Navigator.pushReplacementNamed(context, 'dashboard');
      } else {
        Navigator.pushReplacementNamed(context, 'signin');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/bg.jpg"), fit: BoxFit.cover),
      ),
      child: Center(
          child: Image.asset(
        "images/logo.png",
        width: 90,
        height: 90,
      )),
    );
  }
}
