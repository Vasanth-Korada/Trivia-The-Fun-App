import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Math extends StatefulWidget {
  @override
  _MathState createState() => _MathState();
}

class _MathState extends State<Math> {
  var _mathController = new TextEditingController();
  String mathNumber;
  String content = "";

  Future<Map> getMath(String number) async {
    String apiUrl = "http://numbersapi.com/$number/math?json";

    http.Response response = await http.get(apiUrl);

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.lightBlue,
                  Colors.greenAccent,
                ],
              ),
            ),
          ),
          backgroundColor: Colors.lightBlue,
          title: Text(
            "Math Facts",
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: new Container(
            margin: EdgeInsets.only(bottom: 50.0),
            alignment: Alignment.topCenter,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: new Container(
                    margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 60.0),
                    alignment: Alignment.topCenter,
                    height: 100,
                    width: 250,
                    child: new Image.asset(
                      'images/math.png',
                    ),
                  ),
                ),
                Theme(
                  data: new ThemeData(
                      primaryColor: Colors.blue, primaryColorDark: Colors.blue),
                  child: new TextFormField(
                    validator: (value) {
                      if (value == null) {
                        mathNumber = 0.toString();
                      }
                    },
                    controller: _mathController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "Default Number is 0",
                        labelText: "Enter a Number",
                        prefixIcon: new Icon(Icons.lightbulb_outline),
                        fillColor: Colors.blue,
                        border: OutlineInputBorder(
                            gapPadding: 3.3,
                            borderRadius: BorderRadius.circular(4.3))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: SizedBox(
                    width: 140.0,
                    height: 55.0,
                    child: RaisedButton(
                      splashColor: Colors.lightBlueAccent,
                      elevation: 30.0,
                      highlightColor: Colors.green,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () {
                        setState(() {
                          if (_mathController.text.isNotEmpty) {
                            mathNumber = _mathController.text;
                          } else {
                            mathNumber = 0.toString();
                          }
                        });
                      },
                      color: Colors.lightBlueAccent,
                      child: Text(
                        'Done',
                        style: TextStyle(fontSize: 20.9),
                      ),
                      textColor: Colors.white,
                    ),
                  ),
                ),
                new FutureBuilder(
                    future: getMath(mathNumber),
                    builder:
                        (BuildContext context, AsyncSnapshot<Map> snapshot) {
                      if (snapshot.hasData) {
                        Map content = snapshot.data;
                        if (content['found'] == false) {
                          content['text'] = "Number Not Available ";
                        }
                        return (Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: new BoxDecoration(
                              borderRadius:
                                  new BorderRadius.all(Radius.circular(20.0)),
                              color: Colors.blue,
                              gradient: new LinearGradient(
                                colors: [Colors.lightBlue, Colors.greenAccent],
                              ),
                            ),
                            margin: EdgeInsets.only(top: 30.0),
                            alignment: Alignment.center,
                            width: 290,
                            height: 140,
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Center(
                                  child: Text(
                                content['text'].toString(),
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.white),
                              )),
                            ),
                          ),
                        ));
                      } else {
                        return new Container();
                      }
                    })
              ],
            ),
          ),
        ));
  }
}

TextStyle styleText() {
  return new TextStyle(
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    fontSize: 24.0,
  );
}

TextStyle styleTextDrawer() {
  return new TextStyle(
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    color: Colors.lightBlueAccent.shade400,
    fontSize: 20.0,
  );
}
