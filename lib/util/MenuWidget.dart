import 'package:flutter/material.dart';
import 'package:myhealthdiary/wsInterface.dart';

class MenuWidget extends StatefulWidget {
  final wsInterface wsinterface;
  MenuWidget(this.wsinterface);

  @override
  State<StatefulWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
            padding: EdgeInsets.only(top: 50),
            color: Color(0xffb1c9f1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.house_outlined),
                      title: Text(
                        'Homepage',
                        style:
                            TextStyle(fontSize: 20, color: Color(0xff4d4e50)),
                      ),
                      onTap: () => Navigator.pushNamed(context, 'dashboard'),
                    ),
                    Divider(
                      color: Colors.blueAccent,
                    ),
                    ListTile(
                      leading: Icon(Icons.bluetooth),
                      title: Text(
                        'Connection',
                        style: TextStyle(fontSize: 20, color: Color(0xff4d4e50)),
                      ),
                      onTap: () => Navigator.pushNamed(context, 'connection'),
                    ),
                    Divider(
                      color: Colors.blueAccent,
                    ),
                    ListTile(
                      leading: Icon(Icons.access_alarm_outlined),
                      title: Text(
                        'Reminders',
                        style: TextStyle(fontSize: 20, color: Color(0xff4d4e50)),
                      ),
                      onTap: () => Navigator.pushNamed(context, 'reminders'),
                    ),
                    Divider(
                      color: Colors.blueAccent,
                    ),
                    ListTile(
                      leading: Icon(Icons.file_copy_outlined),
                      title: Text(
                        'Report',
                        style: TextStyle(fontSize: 20, color: Color(0xff4d4e50)),
                      ),
                      onTap: () => Navigator.pushNamed(context, 'report'),
                    ),
                    Divider(
                      color: Colors.blueAccent,
                    ),
                    ListTile(
                      leading: Icon(Icons.insert_chart_outlined),
                      title: Text(
                        'Charts',
                        style: TextStyle(fontSize: 20, color: Color(0xff4d4e50)),
                      ),
                      onTap: () => Navigator.pushNamed(context, 'charts'),
                    ),
                    Divider(
                      color: Colors.blueAccent,
                    ),
                    ListTile(
                      leading: Icon(Icons.text_snippet_outlined),
                      title: Text(
                        'Logs',
                        style: TextStyle(fontSize: 20, color: Color(0xff4d4e50)),
                      ),
                      onTap: () => Navigator.pushNamed(context, 'logs'),
                    ),
                  ],
                ),
                Column(
                  children: [
                   /* ListTile(
                      leading: Icon(Icons.settings),
                      title: Text(
                        'Settings',
                        style: TextStyle(fontSize: 20, color: Color(0xff4d4e50)),
                      ),
                      onTap: () => Navigator.pushNamed(context, 'settings'),
                    ),
                    Divider(
                      color: Colors.blueAccent,
                    ),*/
                    ListTile(
                      leading: Icon(Icons.exit_to_app),
                      title: Text(
                        'Log Out',
                        style: TextStyle(fontSize: 20, color: Color(0xff4d4e50)),
                      ),
                      onTap: () {
                        widget.wsinterface.doLogout();
                        Navigator.pop(context);
                        Navigator.pushNamed(context,'signin');
                      },
                    )
                  ],
                )
              ],
            )));
  }
}
