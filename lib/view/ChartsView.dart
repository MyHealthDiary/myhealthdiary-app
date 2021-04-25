import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myhealthdiary/util/AppBar.dart';
import 'package:myhealthdiary/util/MenuWidget.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../wsInterface.dart';

class ChartsView extends StatefulWidget {
  final wsInterface wsinterface;
  ChartsView(this.wsinterface);

  @override
  _ChartsViewState createState() => _ChartsViewState();}


  class _ChartsViewState extends State<ChartsView> {

  int day1 = 0;
  int day2 = 0;
  int day3 = 0;
  int day4 = 0;
  int day5 = 0;
  int day6 = 0;
  int day7 = 0;


   init() async{
    await fillData();
    Timer(Duration(seconds: 3), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Scaffold(
        appBar: makeAppBar(' Blood Glucose Chart'),
        drawer: MenuWidget(widget.wsinterface),
        backgroundColor: Color(0xfff5f5f5),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 21),
          child: charts.BarChart(
            _createSampleData(),
            animate: true,
            vertical: true,
          ),
        )
        );
  }

  Future<void> fillData() async{
    List<int> returnlist = await widget.wsinterface.fillGlucoseChart();
    day1 = returnlist[0];
    day2 = returnlist[1];
    day3 = returnlist[2];
    day4= returnlist[3];
    day5 = returnlist[4];
    day6 = returnlist[5];
    day7 = returnlist[6];
  }
  List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      new OrdinalSales('Latest', day7),
      new OrdinalSales('Blood', day6),
      new OrdinalSales('Glucose', day5),
      new OrdinalSales('Values', day4),
      new OrdinalSales('Added', day3),
      new OrdinalSales('Chart', day2),
      new OrdinalSales('->', day1),
    ];



    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
