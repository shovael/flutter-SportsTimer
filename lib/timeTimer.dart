import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:audioplayers/audio_cache.dart';

//alaertdaialog on finish ///change from double to divide

class TimeTimer extends StatefulWidget {
  final double set, rest, amount;

  TimeTimer({this.set, this.rest, this.amount});
  TimeTimerState createState() => TimeTimerState();
}

class TimeTimerState extends State<TimeTimer> {
  int number1 = 0, number2 = 1, number3 = 0, number4 = 0, amount;
  double activeTime, set, rest;
  bool isSet, isActive, firstTime;

  @override
  void initState() {
    super.initState();
    //set the basic values for the timer
    setTime(widget.set);
    amount = widget.amount.floor();
    set = widget.set;
    rest = widget.rest;
    isSet = true;
    isActive = false;
    activeTime = -1;
    firstTime = true;
    activeTime = widget.set;
    //A second degree fix for the double tap error
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  void countManage() async {
    //if paused while running
    if (isActive == false && activeTime != -1) {
      setState(() {
        isActive = true;
      });
      if (firstTime == false) {
        await Future.delayed(Duration(seconds: 1));
      } else {
        firstTime = false;
      }
    } else {
      if (isActive == true && activeTime != -1) {
        setState(() {
          isActive = false;
        });
      }
    }
    //change the amount value before the time setting
    if (activeTime == -1) {
      if (isSet == false) {
        setState(() {
          amount -= 1;
        });
      }
    }

    //set the time amount for the correct runing -- zero to set/rep if there are any sets left aka amount>0
    if (amount > 0) {
      if (activeTime == -1) {
        if (isSet == false) {
          isSet = true;
          activeTime = set;
        } else {
          isSet = false;
          activeTime = rest;
        }
      }
    } else {
      //alert dialog "finished congrats"

    }
    startCountDown();
  }

  void startCountDown() async {
    //manages --- ya i know --- the calls for set time and count managers
    while (isActive) {
      if (activeTime == -1) {
        countManage();
        break;
      }
      //play beep sounds at the last 3 sec
      if (activeTime < 4) {
        playLocalAsset();
      }
      setTime(activeTime);
      activeTime -= 1;
      await Future.delayed(Duration(seconds: 1));
    }
  }

  void setTime(double sum) {
    setState(() {
      number1 = (((sum.floor() / 600).floor()) % 7);
      number2 = (((sum.floor() / 60).floor()) % 10);
      number3 = ((sum.floor() % 60 - sum.floor() % 10) / 10).floor();
      number4 = sum.floor() % 10;
    });
  }

  void playLocalAsset() async {
    print("playing");
    AudioCache cache = new AudioCache();
    await cache.play("Blooper-sound-effect.mp3");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(2255, 60, 60, 60),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: MediaQuery.of(context).orientation == Orientation.portrait
                ? MediaQuery.of(context).size.height * 0.325
                : MediaQuery.of(context).size.height * 0.2,
            left: MediaQuery.of(context).orientation == Orientation.portrait
                ? MediaQuery.of(context).size.width * 0.095
                : MediaQuery.of(context).size.width * 0.06,
            child: Text(
              "$number1$number2:$number3$number4",
              style: TextStyle(
                fontSize:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? 130.0
                        : (MediaQuery.of(context).size.height/38)*(MediaQuery.of(context).size.width/38),
                color: Color.fromARGB(255, 255, 14, 14),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).orientation == Orientation.portrait
                ? MediaQuery.of(context).size.height * 0.52
                : MediaQuery.of(context).size.height * 0.3,
            left: MediaQuery.of(context).orientation == Orientation.portrait
                ? MediaQuery.of(context).size.width * 0.375
                : MediaQuery.of(context).size.width * 0.75,
            child: Text(
              (amount > 0 || activeTime != -1)
                  ? "$amount Sets Left"
                  : "Well Done",
              style: TextStyle(
                color: Color.fromARGB(255, 255, 14, 14),
                fontSize:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? 23
                        : 30,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).orientation == Orientation.portrait
                ? MediaQuery.of(context).size.height * 0.77
                : MediaQuery.of(context).size.height * 0.47,
            left: MediaQuery.of(context).orientation == Orientation.portrait
                ? MediaQuery.of(context).size.width * 0.375
                : MediaQuery.of(context).size.width * 0.78,
            child: IconButton(
              icon: isActive == false
                  ? Icon(Icons.play_circle_outline)
                  : Icon(
                      Icons.pause_circle_outline,
                    ),
              iconSize:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? 90.0
                      : 100.0,
              color: Color.fromARGB(255, 255, 14, 14),
              onPressed: () {
                countManage();
              },
            ),
          ),
        ],
      ),
    );
  }
}
