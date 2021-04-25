import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../util/FormUtils.dart';


class LostView extends StatefulWidget {
  @override
  _LostViewState createState() => _LostViewState();
}

class _LostViewState extends State<LostView> {
  final emailController = TextEditingController();
  var resultss;
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Color(0xfff5f5f5),
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'MyHealthDiary',
                  style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff2f5597)),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 20,),
                Image.asset("images/logo.png", height: 70, width: 70,),
                SizedBox(height: 80),
                Form(
                  child: Column(
                    children: [
                      Text("Which is your email?", style: TextStyle(
                        fontSize: 30,
                      color: Color(0xff2f5597),
                      )),
                      SizedBox(height: 25,),
                      FormUtils.getInputText("email", emailController),
                      SizedBox(height: 25),
                      FormUtils.getButton(
                        'Send',
                        () async {
                          Navigator.pushNamed(context, 'emailrecover');
                        },
                      ),
                      SizedBox(height: 60),
                    ],
                  ),
                ),
              ],
            )));
  }
}
