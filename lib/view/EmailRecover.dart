import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../util/FormUtils.dart';

class EmailRecover extends StatefulWidget {
  @override
  _EmailRecoverState createState() => _EmailRecoverState();
}

class _EmailRecoverState extends State<EmailRecover> {

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Color(0xfff5f5f5),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Diabetes: \n Control & Connect',
                  style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff2f5597)),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 80),
                Form(
                  child: Column(
                    children: [
                      Text("Informations to recover your credentials have been sent!",style: TextStyle(
                    fontSize: 25,
                    color: Color(0xff2f5597),
                  )),
                      SizedBox(height: 25),
                      FormUtils.getButton(
                        'Sign In',
                            () async {
                          Navigator.pushNamed(context, 'signin');
                        },
                      ),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            )));
  }
}
