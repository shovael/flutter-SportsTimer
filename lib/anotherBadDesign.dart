// import 'package:flutter/material.dart';
// import 'package:flutter/animation.dart';
// import 'dart:ui';


//  class Main extends StatefulWidget{
//    MainState createState() => MainState();
//  }

//  class MainState extends State<Main> {
//    double height, width;
//    double timeHeight = 30.0, timeWidth = 80.0;
//    double amountHeight = 30.0, amountWidth = 80.0;
//    bool isTime = false, isAmount = false;
//    String timeName = 'time', amountName = 'amount';
//    Duration timeDuration = Duration(milliseconds: 1500);
//    Duration amountDuration = Duration(milliseconds: 1500);
//    Size phoneSize;

//    @override
//    void initState(){
//      super.initState();
//      //for relative posotion, extra stuff 
//      phoneSize = window.physicalSize;
//      height = window.physicalSize.height;
//      width = window.physicalSize.width;
//     //  print(width);
//     //  print(height);
//     //  Future.delayed(Duration(seconds: 3)).whenComplete( () {setState(() {
//     //    temp = 60;
//     //  });});
//    }


//    void sizeController(String type){
//      if(type == "time"){
//        if(isTime == true){
//          isTime = false;
//          setState(() {
//          timeHeight = 30.0;
//          timeWidth = 80.0;
//          });
//        }
//        if(isTime == false && isAmount == false){
//          isTime = true;
//          setState(() {
//            timeWidth = 281;
//            timeHeight = 400.0;
//          });
//        }
//      }

//    }


//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 0,191,255),
//       body: Stack(
//         fit: StackFit.loose,
//         overflow: Overflow.clip,
//         children: <Widget>[
//           Positioned(
//             top: 80.0,
//             left: 47.0,
//             child: Text("Sport\'s Timer",
//               style: TextStyle(
//                 // fontFamily: 'Pacifico',
//                 fontStyle: FontStyle.normal,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 50.0,
//                 color: Color.fromARGB(255, 255, 14, 14),
//               ),
//             ),
//           ),
//           Positioned(
//             top: 350,
//             left: 56.0,
//             child: GestureDetector(
//               onTap: (){
//                 print("time was clicked");
//                 sizeController("time");
//               },
//               child: AnimatedContainer(
//                 duration: timeDuration,
//                 alignment: Alignment.center ,
//                 height: timeHeight,
//                 width: timeWidth,
//                 decoration: BoxDecoration(
//                   color: Color.fromARGB(255,141,2,179),
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//                 child: Text(timeName,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Color.fromARGB(255, 12, 12, 12),
//                 ),
//                 ),
//               ),
//             ),
//           ),
//             Positioned(
//             top: 350.0,
//             left: 257.0,
//             child: GestureDetector(
//               onTap: (){
//                 print("amount was clicked");
//                 sizeController("amount");
//               },
//               child: AnimatedContainer(
//                 duration: amountDuration,
//                 alignment: Alignment.center ,
//                 height: amountHeight,
//                 width: amountWidth,
//                 decoration: BoxDecoration(
//                   color: Color.fromARGB(255,34,139,34),
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//                 child: Text(amountName,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Color.fromARGB(255, 12, 12, 12),
//                 ),
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
  
//  }