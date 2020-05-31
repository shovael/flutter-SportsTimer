import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

import 'timeTimer.dart';
//create app icon  //https://flutter.dev/docs/deployment/android <--DO_THIS-->

//solve the 3600 sec error on this side //fix focus probelm

void main() => runApp(TimerApp());

class TimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sport\'s Timer',
      home: Main(),
      theme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
    );
  }
}

class Main extends StatefulWidget {
  MainState createState() => MainState();
}

class MainState extends State<Main> {
  double height, width;
  Size phoneSize;
  TextEditingController setsTime = TextEditingController();
  TextEditingController restTime = TextEditingController();
  TextEditingController setsAmount = TextEditingController();
  TextEditingController check = TextEditingController();
  FocusNode setField, restField, amountField;

  @override
  void initState() {
    super.initState();
    //for relative posotion, extra stuff
    phoneSize = window.physicalSize;
    height = window.physicalSize.height;
    width = window.physicalSize.width;
    restField = FocusNode();
    amountField = FocusNode();
    setField = FocusNode();
    //lock screen on portrait
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    amountField.dispose();
    restField.dispose();
    setField.dispose();
    //returns the app ability to rotate
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  void timeNavigate() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TimeTimer(
                  amount: setsAmount.text == check.text
                      ? 5.0
                      : double.parse(setsAmount.text),
                  rest: restTime.text == check.text
                      ? 30.0
                      : double.parse(restTime.text),
                  set: setsTime.text == check.text
                      ? 60.0
                      : double.parse(setsTime.text),
                )));
  }

  void showAlertDialog(BuildContext context, String type) {
    setsTime.clear();
    setsAmount.clear();
    restTime.clear();
    SimpleDialog dialog = SimpleDialog(
      children: <Widget>[
        Container(
          height: 360.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                child: Text(
                  "Please Enter:",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 14, 14),
                    fontSize: 22.0,
                  ),
                ),
              ),
              Text(
                "     (Under 60 min)",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 14, 14),
                  fontSize: 12.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15.0, 25.0, 0.0, 0.0),
                child: Container(
                  width: 181.0,
                  child: TextField(
                    autofocus: true,
                    focusNode: setField,
                    cursorColor: Color.fromARGB(255, 255, 14, 14),
                    keyboardType: TextInputType.number,
                    controller: setsTime,
                    maxLength: 4,
                    maxLengthEnforced: true,
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 14, 14),
                    ),
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan),
                      ),
                      hintText: "Sets Length In Second's",
                    ),
                    onSubmitted: ((v) {
                      print(FocusScope.of(context).canRequestFocus);
                      print(FocusScope.of(context).hasFocus);
                      print(FocusScope.of(context).hasPrimaryFocus);
                    }),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 0.0),
                child: Container(
                  width: 181.0,
                  child: TextField(
                    focusNode: restField,
                    cursorColor: Color.fromARGB(255, 255, 14, 14),
                    keyboardType: TextInputType.number,
                    controller: restTime,
                    maxLength: 4,
                    maxLengthEnforced: true,
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 14, 14),
                    ),
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan),
                      ),
                      hintText: "Rest Length In Second's",
                    ),
                    onEditingComplete: () => {
                      FocusScope.of(context).requestFocus(FocusNode()),
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 0.0),
                child: Container(
                  width: 181.0,
                  child: TextField(
                    cursorColor: Color.fromARGB(255, 255, 14, 14),
                    keyboardType: TextInputType.number,
                    controller: setsAmount,
                    maxLength: 2,
                    maxLengthEnforced: true,
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 14, 14),
                    ),
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan),
                      ),
                      hintText: "Amount Of Sets",
                    ),
                    onEditingComplete: () => {
                      FocusScope.of(context).requestFocus(FocusNode()),
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(110.0, 0.0, 0.0, 0.0),
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    SystemChrome.setPreferredOrientations([
                      DeviceOrientation.landscapeRight,
                      DeviceOrientation.landscapeLeft,
                      DeviceOrientation.portraitUp,
                      DeviceOrientation.portraitDown,
                    ]);
                    timeNavigate();
                  },
                  child: Text(
                    "Start",
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 14, 14),
                      fontSize: 30.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(2255, 60, 60, 60),
      body: Stack(
        fit: StackFit.loose,
        overflow: Overflow.clip,
        children: <Widget>[
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            left: MediaQuery.of(context).size.width * 0.095,
            child: Text(
              "Sport\'s Timer",
              style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 50.0,
                color: Color.fromARGB(255, 255, 14, 14),
                letterSpacing: 1,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.435,
            left: MediaQuery.of(context).size.width * 0.13,
            child: GestureDetector(
              onTap: () {
                print("time was clicked");
                showAlertDialog(context, "time");
              },
              child: Container(
                width: 300.0,
                height: 60.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color.fromARGB(255, 255, 14, 14),
                ),
                child: Text(
                  "Set By Time",
                  style: TextStyle(
                    color: Color.fromARGB(2255, 60, 60, 60),
                    fontSize: 25.0,
                    letterSpacing: 5.0,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.56,
            left: MediaQuery.of(context).size.width * 0.13,
            child: GestureDetector(
              onTap: () {
                print("amount was clicked");
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          "Unavailable",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 14, 14),
                            fontSize: 20.0,
                          ),
                        ),
                        content: Text(
                          "Sorry --- Stay tuned",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 14, 14),
                            fontSize: 20.0,
                          ),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Ok",
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 14, 14),
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ],
                      );
                    });
              },
              child: Container(
                width: 300.0,
                height: 60.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color.fromARGB(255, 255, 14, 14),
                ),
                child: Text(
                  "Set By Amount",
                  style: TextStyle(
                    color: Color.fromARGB(2255, 60, 60, 60),
                    fontSize: 25.0,
                    letterSpacing: 5.0,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
