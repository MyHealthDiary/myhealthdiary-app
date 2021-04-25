import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myhealthdiary/util/AppBar.dart';
import 'package:myhealthdiary/util/FormUtils.dart';
import 'package:myhealthdiary/util/MenuWidget.dart';

import '../wsInterface.dart';

class ReportView extends StatefulWidget {
  final wsInterface wsinterface;

  ReportView(this.wsinterface);

  @override
  _ReportViewState createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {
  int _radioValue = -1;

  void handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: makeAppBar('Report'),
        drawer: MenuWidget(widget.wsinterface),
        backgroundColor: Color(0xfff5f5f5),
        resizeToAvoidBottomPadding: false,
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(children: [
              SizedBox(
                height: 40,
              ),
              Text(
                  "In this page you can download the report of your Health Data or upload to the application a .CSV file with the health data extracted from a Fitness Bracelet: ",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center),
              SizedBox(
                height: 40,
              ),
              Image.asset(
                "images/report.png",
                width: 300,
                height: 300,
              ),
              SizedBox(
                height: 23,
              ),
              /*Text("Choose the time period:",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center),
            SizedBox(height: 30,),
            Text("1 Week    1 Month    3 Months",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Radio(
                  value: 0,
                  groupValue: _radioValue,
                  onChanged: handleRadioValueChange,
                ),
                new Text("           "),
                new Radio(
                  value: 1,
                  groupValue: _radioValue,
                  onChanged: handleRadioValueChange,

                ),
                new Text("            "),

                new Radio(
                  value: 2,
                  groupValue: _radioValue,
                  onChanged: handleRadioValueChange,


                ),
              ],
            ),*/
              SizedBox(
                height: 30,
              ),
              FormUtils.getButton('DOWNLOAD CSV', () async {
                bool status = await widget.wsinterface.downloadCSV();
                if (status) {
                  Fluttertoast.showToast(
                      msg: "File downloaded",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM);
                } else {
                  Fluttertoast.showToast(
                      msg: "Error while fetching data",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM);
                }
              }),
              SizedBox(
                height: 10,
              ),
              FormUtils.getButton('UPLOAD CSV', () async {
                bool status = await widget.wsinterface.uploadCSV();
                if (status) {
                  Fluttertoast.showToast(
                      msg: "File Uploaded!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM);
                } else {
                  Fluttertoast.showToast(
                      msg: "Unable to Upload file.",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM);
                }
              }),
            ])));
  }
}
