import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './ui/splashscreen.dart';
//import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(new MaterialApp(
    title: "IP Location App",
    home: new SplashScreen(),
    routes: <String, WidgetBuilder>{
      '/HomeScreen': (BuildContext context) => new Home()
    },
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _ipField = new TextEditingController();
  String ipNumber;
  String content = "";

  Future<Map> getIp(String number) async {
    String apiUrl =
        "http://api.ipstack.com/$ipNumber?access_key=e2f7bfc877c22187b9956576f530105a&format=1";

    http.Response response = await http.get(apiUrl);

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //App Bar
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.lightBlue,
                Colors.deepPurpleAccent,
              ],
            ),
          ),
        ),
        backgroundColor: Colors.blueAccent,
        title: Text(
          "IP Location",
          style: styleText(),
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
                    'images/trivia.png',
                  ),
                ),
              ),
              Theme(
                data: new ThemeData(
                    primaryColor: Colors.blue, primaryColorDark: Colors.blue),
                child: new TextFormField(
                  validator: (value) {
                    if (value == null) {
                      ipNumber = 0.toString();
                    }
                  },
                  controller: _ipField,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "Default Number is 0",
                      labelText: "Enter a IP Address:",
                      prefixIcon: new Icon(Icons.location_on),
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
                        if (_ipField.text.isNotEmpty) {
                          ipNumber = _ipField.text;
                        } else {
                          ipNumber = 0.toString();
                        }
                      });
                    },
                    color: Colors.blueAccent,
                    child: Text(
                      'Done',
                      style: TextStyle(fontSize: 20.9),
                    ),
                    textColor: Colors.white,
                  ),
                ),
              ),
              new FutureBuilder(
                  future: getIp(ipNumber),
                  builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
                    if (snapshot.hasData) {
                      Map content = snapshot.data;
                      if (content['type'] == null) {
                        content['type'] = "Invalid IP";
                      }
                      if (_ipField == null) {
                        return new Container();
                      }
                      return (
                          new Container(
                            child: new Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: new Divider(height: 0.0,color: Colors.red,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: new Text(
                                    "Type : ${content['type']}",
                                    style: TextStyle(fontSize: 24.0),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: new Divider(height: 0.0,color: Colors.red,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: new Text(
                                    "Country : ${content['country_name']}",
                                    style: TextStyle(fontSize: 24.0),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: new Divider(height: 0.0,color: Colors.red,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: new Text(
                                    "State : ${content['region_name']}",
                                    style: TextStyle(fontSize: 24.0),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: new Divider(height: 0.0,color: Colors.red,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: new Text(
                                    "City : ${content['city']}",
                                    style: TextStyle(fontSize: 24.0),
                                  ),
                                ),
                              ],
                            ),
                          )
                      );
                    } else {
                      return new Container();
                    }
                  })
            ],
          ),
        ),
      ),


      //Drawer
      drawer: new Drawer(
        elevation: 20.0,
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: Text(
                "IP Location",
                style: styleText(),
              ),
              accountEmail: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 0.0),
                child: Text(
                  "Email:vasanthkorada@hotmail.com",
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
              currentAccountPicture: new CircleAvatar(
                backgroundImage: new AssetImage('images/bulb.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: new ListTile(
                leading: new Icon(Icons.lightbulb_outline,
                    color: Colors.blue.shade300),
                title: Text(
                  "What's My IP Address?",
                  style: styleTextDrawer(),
                ),
              ),
            ),
            new Divider(
              color: Colors.black45,
              height: 4.0,
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: new ListTile(
                onTap: () {
                  //Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                leading: new Icon(
                  Icons.close,
                  color: Colors.redAccent.shade200,
                ),
                title: Text(
                  "Close",
                  style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                    color: Colors.redAccent.shade200,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
