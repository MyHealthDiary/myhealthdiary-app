import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myhealthdiary/util/AppBar.dart';
import 'package:myhealthdiary/util/FormUtils.dart';
import 'package:myhealthdiary/util/MenuWidget.dart';

import '../wsInterface.dart';

class ReminderView extends StatefulWidget {
  final wsInterface wsinterface;

  ReminderView(this.wsinterface);

  @override
  _ReminderViewState createState() => _ReminderViewState();
}

class _ReminderViewState extends State<ReminderView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: makeAppBar('Reminders'),
        drawer: MenuWidget(widget.wsinterface),
        backgroundColor: Color(0xfff5f5f5),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          decoration: new BoxDecoration(
                              color: Color(0xffd4ddec),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: ListTile(
                            leading: Image.asset(
                              "images/blood.png",
                              width: 55,
                              height: 40,
                            ),
                            title: Text('Check Blood Glucose '),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 0.0),
                            onTap: () => showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      content: Stack(
                                          overflow: Overflow.visible,
                                          children: <Widget>[
                                        Positioned(
                                          right: -40.0,
                                          top: -40.0,
                                          child: InkResponse(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: CircleAvatar(
                                              child: Icon(Icons.close),
                                              backgroundColor:
                                                  Colors.blueAccent,
                                            ),
                                          ),
                                        ),
                                        Form(
                                            child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: (Text(
                                                  "Set Blood Glucose Reminder",
                                                  textAlign: TextAlign.center,
                                                )),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: (Text(
                                                  "Do you need a reminder to measure your Blood Glucose?",
                                                  textAlign: TextAlign.center,
                                                )),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: (Text(
                                                  "It occurs every day at 8.00AM.",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                  textAlign: TextAlign.center,
                                                )),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: FormUtils.getButton(
                                                    'Yes', () async {
                                                  await widget.wsinterface.manageReminder("glucose", "yes");
                                                  Navigator.pop(context);
                                                }),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: FormUtils.getButton(
                                                    'No', () async {
                                                  await widget.wsinterface.manageReminder("glucose", "no");
                                                  Navigator.pop(context);
                                                }),
                                              )
                                            ]))
                                      ]));
                                }),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          decoration: new BoxDecoration(
                              color: Color(0xffd4ddec),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: ListTile(
                            leading: Image.asset(
                              "images/pill.png",
                              width: 55,
                              height: 40,
                            ),
                            title: Text('Take Medicine '),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 0.0),
                            onTap: () => showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      content: Stack(
                                          overflow: Overflow.visible,
                                          children: <Widget>[
                                        Positioned(
                                          right: -40.0,
                                          top: -40.0,
                                          child: InkResponse(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: CircleAvatar(
                                              child: Icon(Icons.close),
                                              backgroundColor:
                                                  Colors.blueAccent,
                                            ),
                                          ),
                                        ),
                                        Form(
                                            child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: (Text(
                                                  "Set Medicine Reminder",
                                                  textAlign: TextAlign.center,
                                                )),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: (Text(
                                                  "In the end of the day, do you need a reminder to check if you took all your pills?",
                                                  textAlign: TextAlign.center,
                                                )),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: (Text(
                                                  "It occurs every day at 9.00PM.",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                  textAlign: TextAlign.center,
                                                )),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: FormUtils.getButton(
                                                    'Yes', () async {
                                                  await widget.wsinterface.manageReminder("medicine", "yes");
                                                  Navigator.pop(context);

                                                }),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: FormUtils.getButton(
                                                    'No', () async {
                                                  await widget.wsinterface.manageReminder("medicine", "no");
                                                  Navigator.pop(context);

                                                }),
                                              )
                                            ]))
                                      ]));
                                }),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          decoration: new BoxDecoration(
                              color: Color(0xffd4ddec),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: ListTile(
                            leading: Image.asset(
                              "images/per.png",
                              width: 55,
                              height: 40,
                            ),
                            title: Text('Activity'),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 0.0),
                            onTap: () => showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      content: Stack(
                                          overflow: Overflow.visible,
                                          children: <Widget>[
                                        Positioned(
                                          right: -40.0,
                                          top: -40.0,
                                          child: InkResponse(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: CircleAvatar(
                                              child: Icon(Icons.close),
                                              backgroundColor:
                                                  Colors.blueAccent,
                                            ),
                                          ),
                                        ),
                                        Form(
                                            child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: (Text(
                                                  "Set Activity Reminder",
                                                  textAlign: TextAlign.center,
                                                )),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: (Text(
                                                  "This reminder will suggest you to take some time for physical activities.",
                                                  textAlign: TextAlign.center,
                                                )),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: (Text(
                                                  "It occurs every day at 4.00PM.",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                  textAlign: TextAlign.center,
                                                )),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: FormUtils.getButton(
                                                    'Yes', () async {
                                                  await widget.wsinterface.manageReminder("activity", "yes");
                                                  Navigator.pop(context);
                                                }),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: FormUtils.getButton(
                                                    'No', () async {
                                                  await widget.wsinterface.manageReminder("activity", "no");
                                                  Navigator.pop(context);

                                                }),
                                              )
                                            ]))
                                      ]));
                                }),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          decoration: new BoxDecoration(
                              color: Color(0xffd4ddec),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: ListTile(
                            leading: Image.asset(
                              "images/bp.png",
                              width: 55,
                              height: 40,
                            ),
                            title: Text('Check Blood Pressure'),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 0.0),
                            onTap: () => showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      content: Stack(
                                          overflow: Overflow.visible,
                                          children: <Widget>[
                                        Positioned(
                                          right: -40.0,
                                          top: -40.0,
                                          child: InkResponse(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: CircleAvatar(
                                              child: Icon(Icons.close),
                                              backgroundColor:
                                                  Colors.blueAccent,
                                            ),
                                          ),
                                        ),
                                        Form(
                                            child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: (Text(
                                                  "Set Blood Pressure Reminder",
                                                  textAlign: TextAlign.center,
                                                )),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: (Text(
                                                  "Do you need a reminder to measure your Blood Pressure?",
                                                  textAlign: TextAlign.center,
                                                )),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: (Text(
                                                  "It occurs every day at 8.00AM.",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                  textAlign: TextAlign.center,
                                                )),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: FormUtils.getButton(
                                                    'Yes', () async {
                                                  await widget.wsinterface.manageReminder("pressure", "yes");
                                                  Navigator.pop(context);
                                                }),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: FormUtils.getButton(
                                                    'No', () async {
                                                  await widget.wsinterface.manageReminder("pressure", "no");
                                                  Navigator.pop(context);
                                                }),
                                              )
                                            ]))
                                      ]));
                                }),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          decoration: new BoxDecoration(
                              color: Color(0xffd4ddec),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: ListTile(
                            leading: Image.asset(
                              "images/scale.png",
                              width: 55,
                              height: 40,
                            ),
                            title: Text('Check Weight'),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 0.0),
                            onTap: () => showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      content: Stack(
                                          overflow: Overflow.visible,
                                          children: <Widget>[
                                        Positioned(
                                          right: -40.0,
                                          top: -40.0,
                                          child: InkResponse(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: CircleAvatar(
                                              child: Icon(Icons.close),
                                              backgroundColor:
                                                  Colors.blueAccent,
                                            ),
                                          ),
                                        ),
                                        Form(
                                            child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: (Text(
                                                  "Set Weight Reminder",
                                                  textAlign: TextAlign.center,
                                                )),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: (Text(
                                                  "Do you need a reminder to measure your weight?",
                                                  textAlign: TextAlign.center,
                                                )),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: (Text(
                                                  "It occurs every day at 8.00PM.",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                  textAlign: TextAlign.center,
                                                )),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: FormUtils.getButton(
                                                    'Yes', () async {
                                                      await widget.wsinterface.manageReminder("weight", "yes");
                                                      Navigator.pop(context);

                                                }),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: FormUtils.getButton(
                                                    'No', () async {
                                                  await widget.wsinterface.manageReminder("weight", "no");
                                                  Navigator.pop(context);
                                                }),
                                              )
                                            ]))
                                      ]));
                                }),
                          )),
                    ],
                  ),
                ),
              ],
            )));
  }
}
