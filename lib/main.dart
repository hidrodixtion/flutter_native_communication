import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:async';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
          primarySwatch: Colors.amber,
          buttonTheme: ButtonThemeData(height: 50.0)),
      home: new MyHomePage(title: 'Flutter ❤️ Native'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const channel = MethodChannel("flutter.testfairy.com/hello");

  Future<Null> _openNewPage() async {
    final response = await channel.invokeMethod("openPage", ["Hi From Flutter"]);
    print(response);
  }

  Future<Null> _showDialog() async {
    final response = await channel.invokeMethod("showDialog", ["Called From Flutter"]);
    print(response);
  }

  Future<Null> _requestNetwork() async {
    final response = await channel.invokeMethod("request", ["https://www.thesportsdb.com/api/v1/json/1/search_all_teams.php?l=English%20Premier%20League"]);
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        // the App.build method, and use it to set our appbar title.
        title: Center(
          child: new Text(widget.title),
        ),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RaisedButton(
                onPressed: () => _openNewPage(),
                child: Text("Open Second Activity / UIViewController"),
                color: Colors.deepPurple,
                textColor: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RaisedButton(
                onPressed: () => _showDialog(),
                child: Text("Show Dialog / Alert"),
                color: Colors.blueAccent,
                textColor: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RaisedButton(
                onPressed: () => _requestNetwork(),
                child: Text("Call Retrofit / Alamofire"),
                color: Colors.teal,
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
    // Here we take the value from the MyHomePage object that was created by
  }
}
