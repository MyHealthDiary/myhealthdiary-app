import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:myhealthdiary/server/HealthData.dart';
import 'package:myhealthdiary/server/csvModel.dart';

class HealthDataWebServices {
  static var client = http.Client();
  static const timeoutDuration = Duration(seconds: 10);
  String server;

  HealthDataWebServices(this.server);

  Future<bool> addHealthData(HealthData data, String email) async {
    try {
      Response response = await client.post(server + '/adddata/', body: {
        'userEmail': email,
        'blood_glucose': data.blood_glucose,
        'hba1c': data.hba1c,
        'heart_rate': data.heart_rate,
        'bloodpressure_max': data.bloodpressure_max,
        'bloodpressure_min': data.bloodpressure_min,
        'carbohydrates': data.carbohydrates,
        'steps': data.steps,
        'sleep': data.sleep,
        'exercise_type': data.exercise_type,
      }).timeout(timeoutDuration, onTimeout: () => throw 'timeout');
      var jsonObj = jsonDecode(response.body);
      String userEmail = jsonObj['userEmail'];
      if (userEmail.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  //find last entry
  Future<HealthData> findHealthDataByUser(String email) async {
    try {
      Response response = await client.post(server + '/databyuser/', body: {
        'userEmail': email
      }).timeout(timeoutDuration, onTimeout: () => throw 'timeout');
      var jsonObj = jsonDecode(response.body);

      double blood_glucose = jsonObj['blood_glucose'];
      double hba1c = jsonObj['hba1c'];
      int heart_rate = jsonObj['heart_rate'];
      int bloodpressure_max = jsonObj['bloodpressure_max'];
      int bloodpressure_min = jsonObj['bloodpressure_min'];
      int carbohydrates = jsonObj['carbohydrates'];
      int steps = jsonObj['steps'];
      int sleep = jsonObj['sleep'];
      String exercise_type = jsonObj['exercise_type'];
      return HealthData(
          blood_glucose.toString(),
          hba1c.toString(),
          heart_rate.toString(),
          bloodpressure_max.toString(),
          bloodpressure_min.toString(),
          carbohydrates.toString(),
          steps.toString(),
          sleep.toString(),
          exercise_type.toString());
    } catch (e) {
      return null;
    }
  }

  Future<List<int>> findUserDataByDay(
      String userEmail, String day, String month, String year) async {
    try {
      Response response = await client.post(server + '/users/databyday/',
          body: {
            'userEmail': userEmail,
            'day': day,
            'month': month,
            'year': year
          }).timeout(timeoutDuration, onTimeout: () => throw 'timeout');
      var jsonList = jsonDecode(response.body);
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<List<int>> findGlucoseDataChart(String email) async {
    try {
      Response response = await client.post(server + '/datachart/', body: {
        'userEmail': email
      }).timeout(timeoutDuration, onTimeout: () => throw 'timeout');
      var jsonObj = jsonDecode(response.body);
      int entry1 = jsonObj["entry1"];
      int entry2 = jsonObj['entry2'];
      int entry3 = jsonObj['entry3'];
      int entry4 = jsonObj['entry4'];
      int entry5 = jsonObj['entry5'];
      int entry6 = jsonObj['entry6'];
      int entry7 = jsonObj['entry7'];
      List<int> returnList = new List();

      returnList.add(entry1);
      returnList.add(entry2);
      returnList.add(entry3);
      returnList.add(entry4);
      returnList.add(entry5);
      returnList.add(entry6);
      returnList.add(entry7);
      return returnList;
    } catch (e) {
      return null;
    }
  }

  Future<List<dynamic>> buildCSV(String email) async {
    try {
      Response response = await client.post(server + '/buildcvsall/', body: {
        'userEmail': email
      }).timeout(timeoutDuration, onTimeout: () => throw 'timeout');
      var jsonObjList = jsonDecode(response.body);
      List returnList;
      List<List<dynamic>> rows = List<List<dynamic>>();

      List<dynamic> FirstRow = List();
      FirstRow.add("Date");
      FirstRow.add("Blood Glucose");
      FirstRow.add("Heart Rate");
      FirstRow.add("Blood Pressure Max");
      FirstRow.add("Blood Pressure Min");
      FirstRow.add("Carbohydrates");
      FirstRow.add("Steps");
      FirstRow.add("Sleep");
      FirstRow.add("Exercise Type");
      rows.add(FirstRow);
      for (var jsonObj in jsonObjList) {
        List<dynamic> row = List();
        row.add(jsonObj['date']);
        row.add(jsonObj['blood_glucose']);
        row.add(jsonObj['heart_rate']);
        row.add(jsonObj['bloodpressure_max']);
        row.add(jsonObj['bloodpressure_min']);
        row.add(jsonObj['carbohydrates']);
        row.add(jsonObj['steps']);
        row.add(jsonObj['sleep']);
        row.add(jsonObj['exercise_type']);
        rows.add(row);
      }
      return rows;
    } catch (e) {
      return null;
    }
  }
}
