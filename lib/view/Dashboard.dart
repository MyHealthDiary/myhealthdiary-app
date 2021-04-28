import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:myhealthdiary/server/HealthData.dart';
import 'package:myhealthdiary/util/AppBar.dart';
import 'package:myhealthdiary/util/FormUtils.dart';
import 'package:myhealthdiary/util/MenuWidget.dart';

import '../wsInterface.dart';

class Dashboard extends StatefulWidget {
  final wsInterface wsinterface;

  Dashboard(this.wsinterface);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var date = DateTime.now();
  HealthData displayData;
  String dBMI;

  String displayBloodGlucose =  "0";
  String displayHbA1c = "0";
  String displayHeartRate = "0";
  String displayBloodPressureMin = "0";
  String displayBloodPressureMax = "0";
  String displaycarbs = "0";
  String displayBMI = "0";
  String displaysteps = "0";
  String displaysleep = "0";





  @override
  void initState() {
    super.initState();
    getDisplayData();
    Timer(Duration(seconds: 1), () {
      setState(() {});
    });
  }

  Future<HealthData> getDisplayData() async {
    displayData = await widget.wsinterface.dashboardDataDisplay();
    if (displayData != null){
      displayBloodGlucose = displayData.blood_glucose.toString();
      displayHbA1c = displayData.hba1c.toString();
      displayHeartRate = displayData.heart_rate.toString();
      displayBloodPressureMin = displayData.bloodpressure_min.toString();
      displayBloodPressureMax = displayData.bloodpressure_max.toString();
      displaycarbs = displayData.carbohydrates.toString();
      displaysteps = displayData.steps.toString();
      displaysleep = displayData.sleep.toString();
      }
    dBMI = await widget.wsinterface.displayBMI();
    if(dBMI != null){
      displayBMI = dBMI;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: makeAppBar('Homepage'),
        drawer: MenuWidget(widget.wsinterface),
        backgroundColor: Color(0xfff5f5f5),
        resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Align(
                  alignment: Alignment(0.9, -0.5),
                  child: Text(
                    DateFormat('EEEE').format(date).toString() +
                        ', ' +
                        date.day.toString() +
                        '-' +
                        date.month.toString() +
                        '-' +
                        date.year.toString(),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff2f5597)),
                  ),
                ),
                Align(
                  alignment: Alignment(-0.8, -0.5),
                  child: Text(
                    "DIABETES",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff2f5597)),
                  ),
                ),
                Container(
                  height: 250.0,
                  width: 400.0,
                  color: Colors.transparent,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff6d9eeb),
                          border: Border.all(color: Colors.blueAccent),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                height: 50.0,
                                color: Colors.transparent,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border:
                                          Border.all(color: Colors.blueAccent),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  child: new Center(
                                    child: new Row(children: <Widget>[
                                      Image.asset(
                                        "images/blood.png",
                                        width: 40,
                                        height: 30,
                                      ),
                                      Text(
                                        "Blood Glucose = ",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                      Text(
                                        displayBloodGlucose,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        " mg/dL",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      )
                                    ]),
                                  ),
                                )),
                          ),
                          Align(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              height: 50.0,
                              color: Colors.transparent,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                        Border.all(color: Colors.blueAccent),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: new Center(
                                  child: new Row(children: <Widget>[
                                    Image.asset(
                                      "images/est.png",
                                      width: 40,
                                      height: 30,
                                    ),
                                    Text(
                                      "HbA1c = ",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      displayHbA1c,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.black),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      " %",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                      textAlign: TextAlign.center,
                                    )
                                  ]),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                height: 50.0,
                                color: Colors.transparent,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border:
                                          Border.all(color: Colors.blueAccent),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  child: new Center(
                                    child: new Row(children: <Widget>[
                                      Image.asset(
                                        "images/hr.png",
                                        width: 40,
                                        height: 30,
                                      ),
                                      Text(
                                        "Heart Rate = ",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        displayHeartRate,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.black),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        " bpm",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                        textAlign: TextAlign.center,
                                      ),
                                    ]),
                                  ),
                                )),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                height: 50.0,
                                alignment: Alignment.center,
                                color: Colors.transparent,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border:
                                          Border.all(color: Colors.blueAccent),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  child: new Center(
                                    child: new Row(children: <Widget>[
                                      Text("  "),
                                      Image.asset(
                                        "images/bp.png",
                                        width: 30,
                                        height: 30,
                                      ),
                                      Text(
                                        " Blood Pressure = ",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(displayBloodPressureMax + "/" + displayBloodPressureMin,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.black),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        " mmHg",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                        textAlign: TextAlign.center,
                                      ),
                                    ]),
                                  ),
                                )),
                          ),
                        ],
                      )),
                ),
                Align(
                  alignment: Alignment(-0.8, -0.5),
                  child: Text(
                    "ACTIVITY",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff2f5597)),
                  ),
                ),
                Container(
                  height: 250.0,
                  width: 400.0,
                  color: Colors.transparent,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff6d9eeb),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              height: 50.0,
                              color: Colors.transparent,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                        Border.all(color: Colors.blueAccent),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: new Center(
                                  child: new Row(children: <Widget>[
                                    Image.asset(
                                      "images/carbs.png",
                                      width: 35,
                                      height: 30,
                                      alignment: Alignment.centerRight,
                                    ),
                                    Text(
                                      " Carbohydrates = ",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      displaycarbs,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.black),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      " gm",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                      textAlign: TextAlign.center,
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                height: 50.0,
                                color: Colors.transparent,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border:
                                          Border.all(color: Colors.blueAccent),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  child: new Center(
                                    child: new Row(children: <Widget>[
                                      Image.asset(
                                        "images/scale.png",
                                        width: 40,
                                        height: 30,
                                      ),
                                      Text(
                                        "BMI = ",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                       displayBMI,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.black),
                                        textAlign: TextAlign.center,
                                      ),
                                    ]),
                                  ),
                                )),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                height: 50.0,
                                color: Colors.transparent,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border:
                                          Border.all(color: Colors.blueAccent),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  child: new Center(
                                    child: new Row(children: <Widget>[
                                      Image.asset(
                                        "images/per.png",
                                        width: 40,
                                        height: 30,
                                      ),
                                      Text(
                                        "Steps = ",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        displaysteps,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.black),
                                        textAlign: TextAlign.center,
                                      ),
                                    ]),
                                  ),
                                )),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                height: 50.0,
                                color: Colors.transparent,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border:
                                          Border.all(color: Colors.blueAccent),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  child: new Center(
                                    child: new Row(children: <Widget>[
                                      Text("  "),
                                      Image.asset(
                                        "images/moon.png",
                                        width: 30,
                                        height: 30,
                                      ),
                                      Text(
                                        "  Sleep = ",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        displaysleep,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.black),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        " h",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                        textAlign: TextAlign.center,
                                      ),
                                    ]),
                                  ),
                                )),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 15,
                ),
                FormUtils.getButton(
                  'Add Logs +',
                  () async {
                    Navigator.pushNamed(context, 'logs');
                  },
                ),
              ],
            )));
  }
}
