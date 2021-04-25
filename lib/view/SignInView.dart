import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myhealthdiary/server/User.dart';
import 'package:myhealthdiary/wsInterface.dart';
import '../util/FormUtils.dart';
import '../server/UserWebServices.dart';

class SignInView extends StatefulWidget {
  final wsInterface wsinterface;
  SignInView(this.wsinterface);

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String textError;
  bool doableLogin = true;

  @override
  void initState() {
    textError = '';
  }

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
                  'MyHealthDiary',
                  style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff2f5597)),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  "images/logo.png",
                  height: 70,
                  width: 70,
                ),
                SizedBox(height: 80),
                Form(
                  child: Column(
                    children: [
                      FormUtils.getInputText("email", emailController),
                      SizedBox(height: 25),
                      FormUtils.getInputText(
                          'password', passwordController, true),
                      SizedBox(height: 35),
                      FormUtils.getButton('Sign In', () async {
                        setState(() {
                          textError = 'Connection...';
                          doableLogin = false;
                        });
                        var email = emailController.text;
                        var password = passwordController.text;
                        bool status = await widget.wsinterface.doLogin(email, password);
                        setState(() {
                          doableLogin = true;
                        });
                        if (status) {
                          Navigator.pushReplacementNamed(context, 'dashboard');
                        } else {
                          setState(() {
                            textError = 'Wrong email or password, try again.';
                          });
                        }
                      }, doableLogin),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        textError,
                        style: TextStyle(
                          color: Color(0xff1C4587),
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      FormUtils.getLink(
                        'Forgot password?',
                        () {
                          Navigator.pushNamed(context, 'lostview');
                        },
                      ),
                      SizedBox(height: 40),
                      SizedBox(height: 40),
                      FormUtils.getLink('New here? Create an account!', () {
                        Navigator.pushNamed(context, 'signup');
                      })
                    ],
                  ),
                ),
              ],
            )));
  }
}
