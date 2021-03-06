import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:toast/toast.dart';

class FormUtils {
  static Widget getInputText(
      String placeholder, TextEditingController controller,
      [bool forPwd = false]) {
    return Container(
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: Color(0xff444444), fontSize: 20),
        // controller: null,
        decoration: InputDecoration(
          /*suffix: forPwd
                ? FlatButton(
                    minWidth: 10,
                    height: 10,
                    child: Icon(
                      Icons.remove_red_eye,
                      color: Color(0xff444444),
                    ),
                    color: Colors.black,
                    onPressed: () {
                      print('alsdfjkhg');
                    },
                  )
                : null,*/
            border: InputBorder.none,
            hintText: placeholder,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
        obscureText: forPwd,
      ),
      decoration: BoxDecoration(
          color: Color(0xff8fb3ef), borderRadius: BorderRadius.circular(12)),
    );
  }

  static Widget getButton(String text, Function onPressed,
      [bool enabled = true]) {
    return SizedBox(
        width: double.infinity,
        child: FlatButton(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            ),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: EdgeInsets.symmetric(vertical: 15),
            color: Color(0xff6d9eeb),
            disabledColor: Color(0xff5c8dda),
            onPressed: enabled ? onPressed : null));
  }

  static Widget getLink(String text, Function onPressed) {
    return SizedBox(
        width: double.infinity,
        child: FlatButton(
            child: Text(
              text,
              style: TextStyle(
                color: Color(0xff1C4587),
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            ),
            onPressed: onPressed));
  }

  static void showToast(String msg, BuildContext context, int duration,
      [bool bottom = true]) {
    Toast.show(msg, context,
        duration: duration, gravity: bottom ? Toast.BOTTOM : Toast.TOP);
  }
}