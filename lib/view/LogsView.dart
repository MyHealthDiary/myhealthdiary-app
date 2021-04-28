import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:myhealthdiary/server/HealthData.dart';
import 'package:myhealthdiary/util/AppBar.dart';
import 'package:myhealthdiary/util/FormUtils.dart';
import 'package:myhealthdiary/util/MenuWidget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:openfoodfacts/model/parameter/TagFilter.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

import '../wsInterface.dart';

class LogsView extends StatefulWidget {
  final wsInterface wsinterface;

  LogsView(this.wsinterface);

  @override
  _LogsViewState createState() => _LogsViewState();
}

class _LogsViewState extends State<LogsView> {
  var date = DateTime.now();

  final bloodController = TextEditingController();
  final carbsController = TextEditingController();
  final WeightController = TextEditingController();
  final ExerciseController = TextEditingController();
  final A1cController = TextEditingController();
  final pressureControllerMax = TextEditingController();
  final pressureControllerMin = TextEditingController();
  final notesController = TextEditingController();
  final quantityController = TextEditingController();
  final stepsController = TextEditingController();
  final heartRateController = TextEditingController();
  final sleepController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: makeAppBar('Logs : ' +
            date.day.toString() +
            '-' +
            date.month.toString() +
            '-' +
            date.year.toString()),
        drawer: MenuWidget(widget.wsinterface),
        backgroundColor: Color(0xfff5f5f5),
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Form(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: [
                          Text(
                            "Time: " +
                                date.hour.toString() +
                                ':' +
                                date.minute.toString(),
                            style: TextStyle(
                                fontSize: 23, color: Color(0xff2f5597)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "images/blood.png",
                            width: 40,
                            height: 30,
                          ),
                          Text("Blood Glucose"),
                          SizedBox(
                            width: 10,
                          ),
                          new Flexible(
                              child: new Container(
                            child: new TextFormField(
                              controller: bloodController,
                              style: TextStyle(
                                  color: Color(0xff444444), fontSize: 16),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 7)),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: Color(0xff8fb3ef),
                                borderRadius: BorderRadius.circular(12)),
                          )),
                          SizedBox(
                            width: 10,
                          ),
                          Text("mg/dL"),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "images/scale.png",
                            width: 40,
                            height: 30,
                          ),
                          Text("Weight"),
                          SizedBox(
                            width: 10,
                          ),
                          new Flexible(
                              child: new Container(
                            child: new TextFormField(
                              controller: WeightController,
                              style: TextStyle(
                                  color: Color(0xff444444), fontSize: 16),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 7)),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: Color(0xff8fb3ef),
                                borderRadius: BorderRadius.circular(12)),
                          )),
                          SizedBox(
                            width: 14,
                          ),
                          Text("kg"),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "images/per.png",
                            width: 40,
                            height: 30,
                          ),
                          Text("Exercise Type"),
                          SizedBox(
                            width: 10,
                          ),
                          new Flexible(
                              child: new Container(
                            child: new TextFormField(
                              controller: ExerciseController,
                              style: TextStyle(
                                  color: Color(0xff444444), fontSize: 16),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Yoga, Running...',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 7)),
                            ),
                            decoration: BoxDecoration(
                                color: Color(0xff8fb3ef),
                                borderRadius: BorderRadius.circular(12)),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "images/est.png",
                            width: 40,
                            height: 30,
                          ),
                          Text("HbA1c"),
                          SizedBox(
                            width: 10,
                          ),
                          new Flexible(
                              child: new Container(
                            child: new TextFormField(
                              controller: A1cController,
                              style: TextStyle(
                                  color: Color(0xff444444), fontSize: 16),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 7)),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: Color(0xff8fb3ef),
                                borderRadius: BorderRadius.circular(12)),
                          )),
                          SizedBox(
                            width: 10,
                          ),
                          Text("%"),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "images/moon.png",
                            width: 40,
                            height: 30,
                          ),
                          Text("Sleep"),
                          SizedBox(
                            width: 10,
                          ),
                          new Flexible(
                              child: new Container(
                                child: new TextFormField(
                                  controller: sleepController,
                                  style: TextStyle(
                                      color: Color(0xff444444), fontSize: 16),
                                  decoration: InputDecoration(
                                      hintText: "How much did you sleep?",
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 7)),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    color: Color(0xff8fb3ef),
                                    borderRadius: BorderRadius.circular(12)),
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Text("h"),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Image.asset(
                            "images/steps.png",
                            width: 40,
                            height: 30,
                          ),
                          Text("Steps"),
                          SizedBox(
                            width: 10,
                          ),
                          new Flexible(
                              child: new Container(
                                child: new TextFormField(
                                  controller: stepsController,
                                  style: TextStyle(
                                      color: Color(0xff444444), fontSize: 16),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 7)),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    color: Color(0xff8fb3ef),
                                    borderRadius: BorderRadius.circular(12)),
                              )),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Image.asset(
                            "images/hr.png",
                            width: 40,
                            height: 30,
                          ),
                          Text("Heart Rate"),
                          SizedBox(
                            width: 10,
                          ),
                          new Flexible(
                              child: new Container(
                                child: new TextFormField(
                                  controller: heartRateController,
                                  style: TextStyle(
                                      color: Color(0xff444444), fontSize: 16),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 7)),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    color: Color(0xff8fb3ef),
                                    borderRadius: BorderRadius.circular(12)),
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Text("bpm"),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Image.asset(
                            "images/bp.png",
                            width: 40,
                            height: 30,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Blood Pressure"),
                          SizedBox(
                            width: 10,
                          ),
                          new Flexible(
                              child: new Container(
                            child: new TextFormField(
                              controller: pressureControllerMax,
                              style: TextStyle(
                                  color: Color(0xff444444), fontSize: 16),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 7)),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: Color(0xff8fb3ef),
                                borderRadius: BorderRadius.circular(12)),
                          )),
                          SizedBox(
                            width: 5,
                          ),
                          Text("/"),
                          SizedBox(
                            width: 5,
                          ),
                          new Flexible(
                              child: new Container(
                            child: new TextFormField(
                              controller: pressureControllerMin,
                              style: TextStyle(
                                  color: Color(0xff444444), fontSize: 16),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 7)),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: Color(0xff8fb3ef),
                                borderRadius: BorderRadius.circular(12)),
                          )),
                          SizedBox(
                            width: 10,
                          ),
                          Text("mm/Hg"),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          decoration: new BoxDecoration(
                              color: Color(0xffd4ddec),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: ListTile(
                            leading: Image.asset(
                              "images/carbs.png",
                              width: 40,
                              height: 30,
                            ),
                            title: Text('Carbohydrates'),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 0.0),
                            onTap: () => showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      content: Stack(
                                          overflow: Overflow.visible,
                                          children: <Widget>[
                                        Positioned(
                                          right: -40.0,
                                          top: -40.0,
                                          child: InkResponse(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: CircleAvatar(
                                              child: Icon(Icons.close),
                                              backgroundColor:
                                                  Colors.blueAccent,
                                            ),
                                          ),
                                        ),
                                        Form(
                                            child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: (Text(
                                                  "Add food",
                                                  textAlign: TextAlign.center,
                                                )),
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: FormUtils.getInputText(
                                                      'Pizza',
                                                      carbsController)),
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: (Text(
                                                  "How many grams?",
                                                  textAlign: TextAlign.center,
                                                )),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: (Text(
                                                  "Add quantity in grams",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                  textAlign: TextAlign.center,
                                                )),
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: FormUtils.getInputText(
                                                      'quantity',
                                                      quantityController)),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: FormUtils.getButton(
                                                    'Submit', () async {
                                                  try {
                                                    String carbs =
                                                        carbsController.text;
                                                    String quantity =
                                                        quantityController.text;
                                                    var parameters =
                                                        <Parameter>[
                                                      const SearchSimple(
                                                          active: true),
                                                      TagFilter(
                                                          tagType: "categories",
                                                          contains: true,
                                                          tagName: carbs),
                                                    ];

                                                    ProductSearchQueryConfiguration
                                                        configuration =
                                                        ProductSearchQueryConfiguration(
                                                            parametersList:
                                                                parameters,
                                                            fields: [
                                                              ProductField.ALL
                                                            ],
                                                            language:
                                                                OpenFoodFactsLanguage
                                                                    .ENGLISH);
                                                    User myUser = User(
                                                        userId: "max@off.com",
                                                        //registered user account  provided by API owners
                                                        password: "password");
                                                    SearchResult result =
                                                        await OpenFoodAPIClient
                                                            .searchProducts(
                                                                myUser,
                                                                configuration);

                                                    double
                                                        nutriScoreFirstProduct =
                                                        result
                                                            .products[1]
                                                            .nutriments
                                                            .carbohydrates; //value for 100 grams
                                                    double scoreForOneGram =
                                                        nutriScoreFirstProduct /
                                                            100;
                                                    double addedCarbs =
                                                        scoreForOneGram *
                                                            int.parse(quantity);
                                                    int intaddedCarbs =
                                                        addedCarbs.toInt();
                                                    String stringcarbs =
                                                        intaddedCarbs
                                                            .toString();
                                                    print(stringcarbs);
                                                    HealthData data =
                                                        HealthData(
                                                            '0',
                                                            '0',
                                                            '0',
                                                            '0',
                                                            '0',
                                                            stringcarbs,
                                                            '0',
                                                            '0',
                                                            '0');
                                                    bool status = await widget
                                                        .wsinterface
                                                        .addLog(data);
                                                    print("Added " +
                                                        carbs +
                                                        " Grams: " +
                                                        quantity +
                                                        ", Calories: " +
                                                        addedCarbs.toString());

                                                    Navigator.pop(context);
                                                    Navigator.pushNamed(
                                                        context, 'dashboard');

                                                    Fluttertoast.showToast(
                                                        msg: "Food correctly added: Added " +
                                                            carbs +
                                                            ", Grams: " +
                                                            quantity +
                                                            ", Total Carbs: " +
                                                            addedCarbs
                                                                .toString(),
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        gravity: ToastGravity
                                                            .BOTTOM);
                                                  } catch (e) {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "ERROR: food not found in our database.",
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        gravity: ToastGravity
                                                            .BOTTOM);
                                                  }
                                                }),
                                              )
                                            ]))
                                      ]));
                                }),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      FormUtils.getButton('Add Log +', () async {
                        var textBloodController = bloodController.text;
                        var textcarbsController = carbsController.text;
                        final textWeightController = WeightController.text;
                        final textExerciseController = ExerciseController.text;
                        final textA1cController = A1cController.text;
                        final textPressureControllerMax =
                            pressureControllerMax.text;
                        final textPressureControllerMin =
                            pressureControllerMin.text;
                        final textStepsController = stepsController.text;
                        final textHeartRateController = heartRateController.text;
                        final textSleepController = sleepController.text;

                        HealthData data = new HealthData(
                            textBloodController,
                            textA1cController,
                            textHeartRateController,
                            textPressureControllerMax,
                            textPressureControllerMin,
                            '0',
                            textStepsController,
                            textSleepController,
                            textExerciseController);
                        bool status = await widget.wsinterface.addLog(data);
                        if (status) {
                          Fluttertoast.showToast(
                              msg: "Log correctly added",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM);
                          widget.wsinterface.checkLatestData(textBloodController, textPressureControllerMax, textPressureControllerMin);

                          Navigator.pushNamed(context, 'dashboard');
                        } else {
                          Fluttertoast.showToast(
                              msg: "ERROR: Check parameters.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM);
                          Navigator.pushNamed(context, 'dashboard');
                        }
                      }),
                    ],
                  ),
                ),
              ],
            )));
  }
}
