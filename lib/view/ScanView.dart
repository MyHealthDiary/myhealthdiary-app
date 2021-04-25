import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myhealthdiary/util/AppBar.dart';
import 'package:myhealthdiary/util/MenuWidget.dart';
import 'package:myhealthdiary/util/BleGattConstants.dart';

import '../wsInterface.dart';

class ScanView extends StatefulWidget {
  final wsInterface wsinterface;

  ScanView(
    this.wsinterface, {
    Key key,
  }) : super(key: key);

  final FlutterBlue flutterBlue = FlutterBlue.instance;
  final List<BluetoothDevice> devicesList = new List<BluetoothDevice>();
  final Map<Guid, List<int>> readValues = new Map<Guid, List<int>>();

  @override
  _ScanViewState createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  final _writeController = TextEditingController();
  BluetoothDevice _connectedDevice;
  List<BluetoothService> _services;

  _addDeviceTolist(final BluetoothDevice device) {
    if (!widget.devicesList.contains(device)) {
      setState(() {
        widget.devicesList.add(device);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    widget.flutterBlue.connectedDevices
        .asStream()
        .listen((List<BluetoothDevice> devices) {
      for (BluetoothDevice device in devices) {
        _addDeviceTolist(device);
      }
    });
    widget.flutterBlue.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        _addDeviceTolist(result.device);
      }
    });
    widget.flutterBlue.startScan();
  }

  ListView _buildListViewOfDevices() {
    List<Container> containers = new List<Container>();
    for (BluetoothDevice device in widget.devicesList) {
      containers.add(
        Container(
          height: 50,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(device.name == '' ? '(unknown device)' : device.name),
                    Text(device.id.toString()),
                  ],
                ),
              ),
              FlatButton(
                color: Colors.blue,
                child: Text(
                  'Connect',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  widget.flutterBlue.stopScan();
                  try {
                    await device.connect();
                    Fluttertoast.showToast(
                        msg: "Connected",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM);
                    Navigator.pushNamed(context, 'dashboard');
                  } catch (e) {
                    if (e.code != 'already_connected') {
                      throw e;
                    }
                  } finally {
                    _services = await device.discoverServices();
                    try {
                      print("looking for servizio");
                      for (BluetoothService service in _services) {
                        if (service.uuid
                            .toString()
                            .contains(BleGATTServices.HEART_RATE_SERVICE)) {
                          print("found service");
                          print(service.uuid.toString());
                          for (BluetoothCharacteristic characteristic
                              in service.characteristics) {
                            print("looking for characteristic");
                            if (characteristic.uuid.toString().contains(
                                BleGATTCharacteristics.HEART_RATE_MEASURMENT)) {
                              print("found characteristic");
                              print(characteristic.descriptors.toString());
                              await characteristic.setNotifyValue(true);
                              await characteristic
                                  .write([0x02, 0x08], withoutResponse: true);
                              characteristic.value.listen((value) {
                                print("Here");
                                print(characteristic.read());
                                print(characteristic.value.toList());
                                print(new String.fromCharCodes(value));
                              });
                            }
                          }
                        }
                      }
                    } catch (e) {}
                  }
                  setState(() {
                    _connectedDevice = device;
                  });
                },
              ),
            ],
          ),
        ),
      );
    }
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...containers,
      ],
    );
  }

  ListView _buildConnectDeviceView() {
    List<Container> containers = new List<Container>();
    try {
      print("cerco servizio");
      for (BluetoothService service in _services) {
        if (service.uuid
            .toString()
            .contains(BleGATTServices.HEART_RATE_SERVICE)) {
          print("trovato servizio");
          print(service.uuid.toString());
          for (BluetoothCharacteristic characteristic
              in service.characteristics) {
            print("cerco characteristic");
            if (characteristic.uuid
                .toString()
                .contains(BleGATTCharacteristics.HEART_RATE_MEASURMENT)) {
              print("found characteristic");
              List<int> s = [
                0x97,
                0x48,
                0x48,
                0x54,
                0x56,
                0x49,
                0x101,
                0x50,
                0x101,
                0x101,
                0x53,
                0x48,
                0x53,
                0x54,
                0x97,
                0x57,
                0x53,
                0x99,
                0x53,
                0x49,
                0x52,
                0x97,
                0x50,
                0x52,
                0x99,
                0x53,
                0x55,
                0x99,
                0x57,
                0x97,
                0x55,
                0x98
              ];

              print('KEY: ' + s.toString());
              characteristic.write(s, withoutResponse: true);
              print(characteristic.descriptors.toString());
              characteristic.setNotifyValue(true);
              characteristic.value.listen((value) {
                print("He2re");
                print(characteristic.read());
                print(characteristic.value.toList());
                print(new String.fromCharCodes(value));
              });
            }
          }
        }
      }
    } catch (e) {
      print(e);
    }

    for (BluetoothService service in _services) {
      List<Widget> characteristicsWidget = new List<Widget>();

      for (BluetoothCharacteristic characteristic in service.characteristics) {
        print("descriptor : " + characteristic.descriptors.toString());
        characteristic.setNotifyValue(true);
        characteristic.value.listen((value) {
          print(new String.fromCharCodes(value));
          print("----------------------------HERE-------------------");
        });
        characteristicsWidget.add(
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(characteristic.uuid.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Row(
                  children: <Widget>[
                    ..._buildReadWriteNotifyButton(characteristic),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('Value: ' +
                        widget.readValues[characteristic.uuid].toString()),
                  ],
                ),
                Divider(),
              ],
            ),
          ),
        );
      }
      containers.add(
        Container(
          child: ExpansionTile(
              title: Text(service.uuid.toString()),
              children: characteristicsWidget),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...containers,
      ],
    );
  }

  List<ButtonTheme> _buildReadWriteNotifyButton(
      BluetoothCharacteristic characteristic) {
    List<ButtonTheme> buttons = new List<ButtonTheme>();

    if (characteristic.properties.read) {
      buttons.add(
        ButtonTheme(
          minWidth: 10,
          height: 20,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: RaisedButton(
              color: Colors.blue,
              child: Text('READ', style: TextStyle(color: Colors.white)),
              onPressed: () async {
                var sub = characteristic.value.listen((value) {
                  setState(() {
                    widget.readValues[characteristic.uuid] = value;
                  });
                });
                await characteristic.read();
                sub.cancel();
              },
            ),
          ),
        ),
      );
    }
    if (characteristic.properties.write) {
      buttons.add(
        ButtonTheme(
          minWidth: 10,
          height: 20,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: RaisedButton(
              child: Text('WRITE', style: TextStyle(color: Colors.white)),
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Write"),
                        content: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                controller: _writeController,
                              ),
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("Send"),
                            onPressed: () {
                              characteristic.write(
                                  utf8.encode(_writeController.value.text));
                              Navigator.pop(context);
                            },
                          ),
                          FlatButton(
                            child: Text("Cancel"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    });
              },
            ),
          ),
        ),
      );
    }
    if (characteristic.properties.notify) {
      buttons.add(
        ButtonTheme(
          minWidth: 10,
          height: 20,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: RaisedButton(
              child: Text('NOTIFY', style: TextStyle(color: Colors.white)),
              onPressed: () async {
                characteristic.value.listen((value) {
                  widget.readValues[characteristic.uuid] = value;
                });
                await characteristic.setNotifyValue(true);
              },
            ),
          ),
        ),
      );
    }

    return buttons;
  }

  ListView _buildView() {
    if (_connectedDevice != null) {
      return _buildConnectDeviceView();
    }
    return _buildListViewOfDevices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: makeAppBar('Connect to Mi Band'),
      drawer: MenuWidget(widget.wsinterface),
      backgroundColor: Color(0xfff5f5f5),
      body: _buildView(),
    );
  }
}
