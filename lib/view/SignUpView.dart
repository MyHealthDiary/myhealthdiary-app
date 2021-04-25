import 'package:flutter/material.dart';
import 'package:myhealthdiary/view/SettingsView.dart';
import 'package:myhealthdiary/wsInterface.dart';
import '../util/FormUtils.dart';


class SignUpView extends StatefulWidget {
  final wsInterface wsinterface;
  SignUpView(this.wsinterface);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();


  @override
  void initState() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       // resizeToAvoidBottomPadding: false,
        backgroundColor: Color(0xfff5f5f5),
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 30,vertical: 50),
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
                      FormUtils.getInputText("email", emailController),
                      SizedBox(height: 25),
                      FormUtils.getInputText(
                          'password', passwordController, true),
                      SizedBox(height: 35),
                      FormUtils.getInputText(
                          'confirm password', passwordConfirmController, true),
                      SizedBox(height: 35),
                      FormUtils.getButton('Sign Up', () async {
                        var email = emailController.text;
                        var password = passwordController.text;
                        var passwordConfirm = passwordConfirmController.text;
                        if(password == passwordConfirm && password.isNotEmpty && email.contains('@')){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SettingsView.registration(widget.wsinterface,email,password),
                              ));
                        } else {
                          FormUtils.showToast("Passwords not matching", context, 3);
                        }
                      }, ),
                      SizedBox(height: 40),

                      SizedBox(height: 40),
                      FormUtils.getLink('Already Have an Account? Login!', () {
                        Navigator.pushNamed(context, 'signin');
                      })
                    ],
                  ),
                ),
              ],
            )));
  }
}
        