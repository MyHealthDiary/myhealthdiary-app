import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:myhealthdiary/createUser.dart';
import 'package:myhealthdiary/server/HealthDataWebServices.dart';
import 'package:myhealthdiary/server/User.dart';
import 'package:myhealthdiary/server/UserWebServices.dart';
import 'package:myhealthdiary/SessionManager.dart';
import 'package:myhealthdiary/util/ReminderNotifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/subjects.dart';
import 'package:csv/csv.dart';
import 'LoginData.dart';
import 'server/HealthData.dart';

class wsInterface {
  UserWebServices userWebServices;
  HealthDataWebServices healthDataWebServices;
  SessionManager sessionManager = SessionManager();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  void init() async {
    // Init user side
    await sessionManager.init();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    NotificationAppLaunchDetails notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    await initNotifications(flutterLocalNotificationsPlugin);
    initNotifications(flutterLocalNotificationsPlugin);
    try {
      var checkRemindersInitialized = await sessionManager.getReminders();
      if (checkRemindersInitialized[0] != null) {
        print("reminder scheduled");
        await scheduleReminders();
      } else {
        print("Reminder init");
        await sessionManager.initReminders();
      }
    } catch (e) {
      print(e);
    }

    // setup reminders
    /* if (sessionManager.isUserLogged()) {
      LoginData loginData = await sessionManager.getLoggedUser();
      if (loginData != null) {
        await sessionManager.setLoggedUser(loginData);
      } else {
        //await sessionManager.removeLoggedUser();
      }
    }*/
  }

  bool isUserLogged() {
    return sessionManager.isUserLogged();
  }

  void setUserWs(UserWebServices userWebServices) {
    this.userWebServices = userWebServices;
  }

  Future<bool> doLogin(String email, String password) async {
    print(email);
    User user = await userWebServices.findUserByCredentials(email, password);
    print(user.toString());
    if (user != null) {
      LoginData loginData = LoginData(user.email);
      await sessionManager.setLoggedUser(loginData);
      return true;
    } else {
      await sessionManager.removeLoggedUser();
      return false;
    }
  }

  Future<User> findUserByEmail(String email) async {
    User user = await userWebServices.findUserByEmail(email);
    if (user != null) {
      return user;
    } else
      return null;
  }

  void doLogout() async {
    await sessionManager.removeLoggedUser();
  }

  Future<bool> createAccount(createUser newUser) async {
    bool success = await userWebServices.createAccount(newUser);
    if (success) {
      LoginData loginData = LoginData(newUser.email);
      await sessionManager.setLoggedUser(loginData);
      return true;
    } else {
      await sessionManager.removeLoggedUser();
      return false;
    }
  }

  Future<bool> addLog(HealthData data) async {
    LoginData loginData = await sessionManager.getLoggedUser();
    print(data.blood_glucose +
        data.carbohydrates +
        data.bloodpressure_max +
        data.bloodpressure_min +
        data.exercise_type +
        data.hba1c +
        data.heart_rate +
        data.sleep +
        data.steps);

    bool success =
        await healthDataWebServices.addHealthData(data, loginData.email);
    if (success) {
      return true;
    } else {
      return false;
    }
  }

  void setHealthDataWs(HealthDataWebServices healtdatawebservices) {
    this.healthDataWebServices = healtdatawebservices;
  }

  Future<String> displayBMI() async {
    LoginData logindata = await sessionManager.getLoggedUser();
    print("stampo" + logindata.email);
    String email = logindata.email;
    User user = await userWebServices.findUserByEmail(email);
    if (user != null) {
    double height = double.parse(user.height);
    double weight =  double.parse(user.weight);

    double cmHeight = (height / 100);
    double BMI = (weight / (cmHeight * cmHeight));
    String bmiString = BMI.toStringAsFixed(2);

      return  bmiString;
    } else {
      return null;
    }
  }

  Future<HealthData> dashboardDataDisplay() async {
    LoginData logindata = await sessionManager.getLoggedUser();
    print(logindata.email);
    String email = logindata.email;
    HealthData returnData =
        await healthDataWebServices.findHealthDataByUser(email);
    if (returnData != null) {
      return returnData;
    } else {
      return null;
    }
  }

  Future<List<int>> fillGlucoseChart() async {
    LoginData logindata = await sessionManager.getLoggedUser();
    print(logindata.email);
    String email = logindata.email;
    List<int> returnList =
        await healthDataWebServices.findGlucoseDataChart(email);
    if (returnList != null) {
      return returnList;
    } else {
      return null;
    }
  }

  final BehaviorSubject<ReminderNotification>
      didReceiveLocalNotificationSubject =
      BehaviorSubject<ReminderNotification>();

  final BehaviorSubject<String> selectNotificationSubject =
      BehaviorSubject<String>();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification:
            (int id, String title, String body, String payload) async {
          didReceiveLocalNotificationSubject.add(ReminderNotification(
              id: id, title: title, body: body, payload: payload));
        });
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      if (payload != null) {
        debugPrint('notification payload: ' + payload);
      }
      selectNotificationSubject.add(payload);
    });
  }

  Future<void> scheduleNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      String id,
      String body,
      DateTime datetime) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      id,
      'Reminder notifications',
      'Remember about it',
      icon: '@mipmap/ic_launcher',
    );
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        0, 'Healthy Reminder', body, datetime, platformChannelSpecifics);
  }

  Future<void> manageReminder(String id, String value) async {
    await sessionManager.setReminder(id, value);
  }

  void scheduleReminders() async {
    var reminderList = await sessionManager.getReminders();
    DateTime scheduledNotificationDateTime = DateTime.now();
    print("reminderList " + reminderList.toString());
    print("first element" + reminderList[0]);
    if (reminderList[0].contains("yes")) {
      //blood
      DateTime date = new DateTime(
          scheduledNotificationDateTime.year,
          scheduledNotificationDateTime.month,
          scheduledNotificationDateTime.day,
          8,
          0,
          0,
          0,
          0);
      String body =
          "Good Morning! Remember to measure the glucose level before to eat!";
      await scheduleNotification(
          flutterLocalNotificationsPlugin, "0", body, date);
    }
    if (reminderList[1].contains("yes")) {
      //pressure
      DateTime date = new DateTime(
          scheduledNotificationDateTime.year,
          scheduledNotificationDateTime.month,
          scheduledNotificationDateTime.day,
          8,
          0,
          0,
          0,
          0);
      String body = "Good Morning! Remember to measure the blood pressure!";
      await scheduleNotification(
          flutterLocalNotificationsPlugin, "0", body, date);
    }
    if (reminderList[2].contains("yes")) {
      //medicine
      DateTime date = new DateTime(
          scheduledNotificationDateTime.year,
          scheduledNotificationDateTime.month,
          scheduledNotificationDateTime.day,
          21,
          0,
          0,
          0,
          0);
      String body =
          "Hello, this is a reminder! Did you take all your medicine for the day? If not, do it!";
      await scheduleNotification(
          flutterLocalNotificationsPlugin, "0", body, date);
    }
    if (reminderList[3].contains("yes")) {
      //weight
      DateTime date = new DateTime(
          scheduledNotificationDateTime.year,
          scheduledNotificationDateTime.month,
          scheduledNotificationDateTime.day,
          20,
          0,
          0,
          0,
          0);
      String body =
          "Good Evening! Do not forget to check your weight of today!";
      await scheduleNotification(
          flutterLocalNotificationsPlugin, "0", body, date);
    }
    if (reminderList[4].contains("yes")) {
      //exercise
      DateTime date = new DateTime(
          scheduledNotificationDateTime.year,
          scheduledNotificationDateTime.month,
          scheduledNotificationDateTime.day,
          16,
          0,
          0,
          0,
          0);
      String body =
          "Good Afternoon! What do you think about some exercise? Just few minutes of stretching really helps your body!";
      await scheduleNotification(
          flutterLocalNotificationsPlugin, "0", body, date);
    }
  }

  Future<bool> downloadCSV() async {
    try {
      LoginData loginData = await sessionManager.getLoggedUser();
      var dataList = await healthDataWebServices.buildCSV(loginData.email);
      await Permission.storage.request();
      bool status = await Permission.storage.isGranted;
      if (status) {
        String dir =
            (await getExternalStorageDirectory()).absolute.path + "/documents";
        String file = "$dir";
        print(" FILE " + file);
        File f = new File(file + "MyHealthDiaryREPORT.csv");

        String csv = const ListToCsvConverter().convert(dataList);
        f.writeAsString(csv);
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> readCSV(Stream<List<int>> input) async {
    String csvType = "null";
    try {
      await input
          .transform(utf8.decoder) // Decode bytes to UTF-8.
          .transform(new LineSplitter())
          .listen((String line) async {
        List row = line.split(','); // split by comma
        if (csvType == "null") {
          for (var elements in row) {
            if (elements.toString() == "deepSleepTime") {
              csvType = "deepSleepTime";
            } else if (elements.toString() == "heartRate") {
              csvType = "heartRate";
            } else if (elements.toString() == "steps") {
              csvType = "steps";
            }
          }
        } else if (csvType == "deepSleepTime") {
          HealthData data = new HealthData(
              "0", "0", "0", "0", "0", "0", "0", row[2].toString(), "0");
          await addLog(data);
        } else if (csvType == "heartRate") {
          HealthData data = new HealthData(
              "0", "0", row[2].toString(), "0", "0", "0", "0", "0", "0");
          await addLog(data);
        } else if (csvType == "steps") {
          HealthData data = new HealthData(
              "0", "0", "0", "0", "0", "0", row[2].toString(), "0", "0");
          await addLog(data);
        } else {
          return false;
        }
      });
      return true;
    } catch (e) {
      print("read error");
    }
  }

  Future<bool> uploadCSV() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      PlatformFile file = result.files.first;
      final input = new File(file.path).openRead();
      bool csv = await readCSV(input);
      return csv;
    }
  }
}
