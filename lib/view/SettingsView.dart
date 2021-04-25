import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myhealthdiary/server/User.dart';
import 'package:myhealthdiary/util/AppBar.dart';
import 'package:myhealthdiary/util/MenuWidget.dart';
import '../createUser.dart';
import '../util/FormUtils.dart';
import '../wsInterface.dart';

class SettingsView extends StatefulWidget {
  final wsInterface wsinterface;
  final String email;
  final String password;

  SettingsView.registration(this.wsinterface, this.email, this.password);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final height = TextEditingController();
  final weight = TextEditingController();
  final date = TextEditingController();
  final gender = TextEditingController();
  final diabetestype = TextEditingController();

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff5f5f5),
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 80),
                  Form(
                      child: Column(children: <Widget>[
                    SizedBox(height: 30),
                    Text("Add  your personal informations",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                        )),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text("First Name: ",
                            style: TextStyle(
                              fontSize: 18,
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        new Flexible(
                            child: new Container(
                          child: new TextFormField(
                            controller: firstname,
                            style: TextStyle(
                                color: Color(0xff444444), fontSize: 16),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 7)),
                          ),
                          decoration: BoxDecoration(
                              color: Color(0xff8fb3ef),
                              borderRadius: BorderRadius.circular(12)),
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                        Row(
                          children: [
                            Text("Last Name: ",
                                style: TextStyle(
                                  fontSize: 18,
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            new Flexible(
                                child: new Container(
                                  child: new TextFormField(
                                    controller: lastname,
                                    style: TextStyle(
                                        color: Color(0xff444444), fontSize: 16),
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 7)),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Color(0xff8fb3ef),
                                      borderRadius: BorderRadius.circular(12)),
                                )),
                          ],
                        ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text("Birthdate: ",
                            style: TextStyle(
                              fontSize: 18,
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        new Flexible(
                            child: new Container(
                          child: new TextFormField(
                            controller: date,
                            style: TextStyle(
                                color: Color(0xff444444), fontSize: 16),
                            decoration: InputDecoration(
                                hintText: "yyyy-MM-dd",
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 7)),
                            keyboardType: TextInputType.number,
                          ),
                          decoration: BoxDecoration(
                              color: Color(0xff8fb3ef),
                              borderRadius: BorderRadius.circular(12)
                          ),
                        )),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text("Gender: ",
                            style: TextStyle(
                              fontSize: 18,
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        new Flexible(
                            child: new Container(
                          child: new TextFormField(
                            controller: gender,
                            style: TextStyle(
                                color: Color(0xff444444), fontSize: 16),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 7)),
                          ),
                          decoration: BoxDecoration(
                              color: Color(0xff8fb3ef),
                              borderRadius: BorderRadius.circular(12)),
                        )),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text("Diabetes type: ",
                            style: TextStyle(
                              fontSize: 18,
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        new Flexible(
                            child: new Container(
                          child: new TextFormField(
                            controller: diabetestype,
                            style: TextStyle(
                                color: Color(0xff444444), fontSize: 16),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 7)),
                          ),
                          decoration: BoxDecoration(
                              color: Color(0xff8fb3ef),
                              borderRadius: BorderRadius.circular(12)),
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("     Add your height in centimeters.",
                        style: TextStyle(fontStyle: FontStyle.italic)),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text("Height: ",
                            style: TextStyle(
                              fontSize: 18,
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        new Flexible(
                            child: new Container(
                          child: new TextFormField(
                            controller: height,
                            style: TextStyle(
                                color: Color(0xff444444), fontSize: 16),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 7)),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: Color(0xff8fb3ef),
                              borderRadius: BorderRadius.circular(12)),
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("   Add your weight in kilograms.",
                        style: TextStyle(fontStyle: FontStyle.italic)),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text("Weight: ",
                            style: TextStyle(
                              fontSize: 18,
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        new Flexible(
                            child: new Container(
                          child: new TextFormField(
                            controller: weight,
                            style: TextStyle(
                                color: Color(0xff444444), fontSize: 16),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 7)),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: Color(0xff8fb3ef),
                              borderRadius: BorderRadius.circular(12)),
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    FormUtils.getButton('Save', () async {
                      String fname = firstname.text;
                      String lname = lastname.text;
                      String varheight = height.text;
                      String varweight = weight.text;
                      String email = widget.email;
                      String password = widget.password;
                      String birthdate = date.text;
                      String vargender = gender.text;
                      String diabettype = diabetestype.text;


                      createUser newUser = new createUser(
                          email,
                          password,
                          fname,
                          lname,
                          birthdate,
                          vargender,
                          varheight,
                          varweight,
                          diabettype);
                      bool status =
                          await widget.wsinterface.createAccount(newUser);
                      if (status) {
                        Fluttertoast.showToast(
                            msg: "Changes saved",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM);
                        Navigator.pushNamed(context, 'dashboard');
                      } else {
                        Fluttertoast.showToast(
                            msg: "Error: check the inserted data and try again!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM);
                      }
                    }),
                  ]))
                ])));
  }
}
