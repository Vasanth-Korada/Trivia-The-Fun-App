import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Year extends StatefulWidget {
  @override
  _YearState createState() => _YearState();
}

class _YearState extends State<Year> {
  var _yearController = new TextEditingController();
  String yearNumber;
  String content = "";

  Future<Map> getMath(String number) async {
    String apiUrl = "http://numbersapi.com/$number/year?json";

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
                  Colors.lightBlue.shade700,
                  Colors.lightBlueAccent,
                ],
              ),
            ),
          ),
          backgroundColor: Colors.lightBlue.shade400,
          title: Text(
            "Year Facts",
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
                    margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 40.0),
                    alignment: Alignment.topCenter,
                    height: 100,
                    width: 250,
                    child: new Image.asset(
                      'images/calendar1.png',
                    ),
                  ),
                ),
                Theme(
                  data: new ThemeData(
                      primaryColor: Colors.blue, primaryColorDark: Colors.blue),
                  child: new TextFormField(
                    validator: (value) {
                      if (value == null) {
                        yearNumber = 0.toString();
                      }
                    },
                    controller: _yearController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "Eg.1999",
                        labelText: "Enter a Year",
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
                          if (_yearController.text.isNotEmpty) {
                            yearNumber = _yearController.text;
                          } else {
                            yearNumber = 0.toString();
                          }
                        });
                      },
                      color: Colors.lightBlueAccent.shade400,
                      child: Text(
                        'Done',
                        style: TextStyle(fontSize: 20.9),
                      ),
                      textColor: Colors.white,
                    ),
                  ),
                ),
                new FutureBuilder(
                    future: getMath(yearNumber),
                    builder:
                        (BuildContext context, AsyncSnapshot<Map> snapshot) {
                      if (snapshot.hasData) {
                        Map content = snapshot.data;
                        if (content['found'] == false) {
                          content['text'] = "Year Not Available ";
                        }
                        return (Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: new BoxDecoration(
                              borderRadius:
                                  new BorderRadius.all(Radius.circular(20.0)),
                              color: Colors.blue,
                              gradient: new LinearGradient(
                                colors: [
                                  Colors.lightBlue.shade700,
                                  Colors.lightBlueAccent
                                ],
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
