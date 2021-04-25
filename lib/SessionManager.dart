import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LoginData.dart';

class SessionManager {
  SharedPreferences prefs;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();

  }

  bool isUserLogged() {
    return prefs.containsKey('sessEmail');
  }

  Future<LoginData> getLoggedUser() async {
    return await LoginData(prefs.getString('sessEmail'));
  }

  void setLoggedUser(LoginData loginData) async {
    await prefs.setString('sessEmail', loginData.email);
  }

  void removeLoggedUser() async {
    await prefs.remove('sessEmail');
  }

  void setReminder(String reminderName, String value) async {
    await prefs.setString(reminderName, value);
  }

  Future<List<String>> getReminders() async {
    List reminderList = new List<String>();
    String bloodReminder = await prefs.getString('glucose');
    String pressureReminder = await prefs.getString('pressure');
    String medicineReminder = await prefs.getString('medicine');
    String weightReminder = await prefs.getString('weight');
    String activityReminder = await prefs.getString('activity');
    reminderList.add(bloodReminder);
    reminderList.add(pressureReminder);
    reminderList.add(medicineReminder);
    reminderList.add(weightReminder);
    reminderList.add(activityReminder);
    return reminderList;
  }

  void initReminders() async {
    await prefs.setString("glucose", "no");
    await prefs.setString("pressure", "no");
    await prefs.setString("medicine", "no");
    await prefs.setString("weight", "no");
    await prefs.setString("activity", "no");
  }
}
