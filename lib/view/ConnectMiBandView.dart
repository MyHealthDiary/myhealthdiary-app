import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myhealthdiary/util/AppBar.dart';
import 'package:myhealthdiary/util/FormUtils.dart';
import 'package:myhealthdiary/util/MenuWidget.dart';

import '../wsInterface.dart';

class ConnectMiBandView extends StatefulWidget {
  final wsInterface wsinterface;
  ConnectMiBandView(this.wsinterface);
  @override
  _ConnectMiBandViewState createState() => _ConnectMiBandViewState();
}

class _ConnectMiBandViewState extends State<ConnectMiBandView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: makeAppBar('Connect to Mi Band'),
        drawer: MenuWidget(widget.wsinterface),
        backgroundColor: Color(0xfff5f5f5),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                SizedBox(height: 40,),
                Text(
                    'To connect your Mi Band, you need to press Connect, '
                        'find your device in the list of available devices '
                        'and tap Pair.',
                    style: TextStyle(fontSize: 23),
                    textAlign: TextAlign.center),
                SizedBox(height: 40,),
                Image.asset(
                  "images/miband.png",
                  width: 350,
                  height: 350,
                ),
                SizedBox(height: 40,),
                FormUtils.getButton('CONNECT', () async {
                  Navigator.pushNamed(context, 'scanview');
                }),
              ],
            )));
  }
}
