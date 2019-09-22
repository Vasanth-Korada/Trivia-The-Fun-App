import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Date extends StatefulWidget {
  @override
  _DateState createState() => _DateState();
}

class _DateState extends State<Date> {
  var _dateController = new TextEditingController();
  String dateNumber;
  String content = "";

  Future<Map> getDate(String number) async {
    String apiUrl = "http://numbersapi.com/$number/date?json";

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
                  Colors.blue.shade900,
                  Colors.lightBlue,
                ],
              ),
            ),
          ),
          backgroundColor: Colors.blue.shade900,
          title: Text(
            "Date Facts",
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
                      'images/calendar.png',
                    ),
                  ),
                ),
                Theme(
                  data: new ThemeData(
                      primaryColor: Colors.blue, primaryColorDark: Colors.blue),
                  child: new TextFormField(
                    validator: (value) {
                      if (value == null) {
                        dateNumber = 0.toString();
                      }
                    },
                    controller: _dateController,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                        hintText: "Default Date : 12/31",
                        labelText: "Enter Date(month/day)",
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
                          if (_dateController.text.isNotEmpty) {
                            dateNumber = _dateController.text;
                          } else {
                            dateNumber = 0.toString();
                          }
                        });
                      },
                      color: Colors.blue.shade800,
                      child: Text(
                        'Done',
                        style: TextStyle(fontSize: 20.9),
                      ),
                      textColor: Colors.white,
                    ),
                  ),
                ),
                new FutureBuilder(
                    future: getDate(dateNumber),
                    builder:
                        (BuildContext context, AsyncSnapshot<Map> snapshot) {
                      if (snapshot.hasData) {
                        Map content = snapshot.data;
                        if (content['found'] == false) {
                          content['text'] = "Number Not Available ";
                        }
                        return (Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: new BoxDecoration(
                              borderRadius:
                                  new BorderRadius.all(Radius.circular(20.0)),
                              color: Colors.blue,
                              gradient: new LinearGradient(
                                colors: [
                                  Colors.blue.shade900,
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
