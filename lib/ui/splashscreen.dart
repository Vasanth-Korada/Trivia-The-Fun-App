import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/widgets.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/HomeScreen');
  }

  startTime() async {
    var _duration = new Duration(seconds: 4);
    return new Timer(_duration, navigationPage);
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1200,
      height: 1200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.lightBlue,
            Colors.deepPurpleAccent
          ],
        ),
      ),
      child: new Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Center(
              child: new Image.asset('images/bulb.png'),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: new Text(
                "The Trivia App",
                style: TextStyle(
                    fontSize: 38.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow.shade500,
                    fontStyle: FontStyle.normal),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
