import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project/screens/welcome/Welcome_Page.dart';

void main() {
  runApp(Splash_Screen());
}

class Splash_Screen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<Splash_Screen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = Duration(seconds: 2);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Welcome_Page()));
  }

  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Color(0xffd8dad9),
      body: Center(
          child:Container(
            child: Image.asset("assests/images/Logo_black.gif"),
      )),
    );
  }
}
