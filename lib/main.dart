import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myhealthdiary/server/HealthData.dart';
import 'package:myhealthdiary/server/HealthDataWebServices.dart';
import 'package:myhealthdiary/server/UserWebServices.dart';
import 'package:myhealthdiary/view/ChartsView.dart';
import 'package:myhealthdiary/view/ConnectMiBandView.dart';
import 'package:myhealthdiary/view/LogsView.dart';
import 'package:myhealthdiary/view/ReminderView.dart';
import 'package:myhealthdiary/view/ReportView.dart';
import 'package:myhealthdiary/view/ScanView.dart';
import 'package:myhealthdiary/view/SettingsView.dart';
import 'package:myhealthdiary/wsInterface.dart';
import 'view/CalendarView.dart';
import 'view/SplashScreen.dart';
import 'view/SignInView.dart';
import 'view/SignUpView.dart';
import 'view/Dashboard.dart';
import 'view/LostView.dart';
import 'view/EmailRecover.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final wsInterface wsinterface = wsInterface();
  final String localhost = 'http://172.19.193.250:8080';
  String email = "";
  String password = "";
  var userwebservices = UserWebServices(localhost);
  wsinterface.setUserWs(userwebservices);
  var healtdatawebservices = HealthDataWebServices(localhost);
  wsinterface.setHealthDataWs(healtdatawebservices);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) =>

  runApp(MaterialApp(
    title: 'MyHealthDiary',
    debugShowCheckedModeBanner: false,
    home: SplashScreen(wsinterface),
    routes: {
      'signin': (BuildContext context) => SignInView(wsinterface),
      'signup': (BuildContext context) => SignUpView(wsinterface),
      'dashboard': (BuildContext context) => Dashboard(wsinterface),
      'lostview': (BuildContext context) => LostView(),
      'emailrecover': (BuildContext context) => EmailRecover(),
      'calendarview': (BuildContext context) => CalendarView(),
      'connection': (BuildContext context) => ConnectMiBandView(wsinterface),
      'reminders' : (BuildContext context) => ReminderView(wsinterface),
      'calendarview' :  (BuildContext context) => CalendarView(),
      'report' :  (BuildContext context) => ReportView(wsinterface),
      'charts' : (BuildContext context) => ChartsView(wsinterface),
      'logs' :  (BuildContext context) => LogsView(wsinterface),
      'scanview' :  (BuildContext context) => ScanView(wsinterface),
      'settings' :  (BuildContext context) => SettingsView.registration(wsinterface,email, password),

    },
  )));
}

