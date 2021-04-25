import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:myhealthdiary/createUser.dart';

import 'User.dart';

class UserWebServices {
  static var client = http.Client();
  static const timeoutDuration = Duration(seconds: 10);
  String server;

  UserWebServices(this.server);

  Future<User> findUserByCredentials(String email, String password) async {
    print(server + '/users/login/');
    try {
      Response response = await client.post(server + '/users/login/', body: {
        'email': email,
        'password': password
      }).timeout(timeoutDuration, onTimeout: () => throw 'timeout');
      var jsonObj = jsonDecode(response.body);
      String userEmail = jsonObj['email'];
      String userPassword = jsonObj['password'];
      String userFirstName = jsonObj['firstname'];
      String userLastName = jsonObj['lastname'];
      String userBirthDate = jsonObj['birthdate'];
      String userGender = jsonObj['gender'];
      int userHeight = jsonObj['height'];
      double userWeight = jsonObj['weight'];
      String userDiabetType = jsonObj['diabet_type'];
      print(userEmail.toLowerCase());
      if (userEmail != null) {
        return User(userEmail, userPassword, userFirstName, userLastName,
            userBirthDate, userGender, userHeight.toString(), userWeight.toString(), userDiabetType);
      } else
        return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User> findUserByEmail(
    String email,
  ) async {
    try {
      Response response = await client
          .post(server + '/users/findbyemail/',body: {
        'email': email}).timeout(timeoutDuration, onTimeout: () => throw 'timeout');
      var jsonObj = jsonDecode(response.body);
      String userEmail = jsonObj['email'];
      String userPassword = jsonObj['password'];
      String userFirstName = jsonObj['firstname'];
      String userLastName = jsonObj['lastname'];
      String userBirthDate = jsonObj['birthdate'];
      String userGender = jsonObj['gender'];
      int userHeight = jsonObj['height'];
      double userWeight = jsonObj['weight'];
      String userDiabetType = jsonObj['diabet_type'];
      return User(userEmail, userPassword, userFirstName, userLastName,
          userBirthDate, userGender, userHeight.toString(), userWeight.toString(), userDiabetType);
    } catch (e) {
      return null;
    }
  }

  Future<bool> createAccount(createUser newUser) async {
    try {
      Response response = await client.post(server + '/users/newuser/', body: {
        'email': newUser.email,
        'password': newUser.password,
        'firstname': newUser.firstname,
        'lastname': newUser.lastname,
        'birthdate': newUser.birthdate,
        'gender': newUser.gender,
        'height': newUser.height,
        'weight': newUser.weight,
        'diabet_type': newUser.diabet_type
      }).timeout(timeoutDuration, onTimeout: () => throw 'timeout');
      var jsonObj = jsonDecode(response.body);
      String userEmail = jsonObj['email'];
      print(userEmail);
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
}
