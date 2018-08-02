import 'package:flutter/material.dart';

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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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
                onPressed: () {},
                child: Text("Open Second Activity / UIViewController"),
                color: Colors.deepPurple,
                textColor: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RaisedButton(
                onPressed: () {},
                child: Text("Show Dialog / Alert"),
                color: Colors.blueAccent,
                textColor: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RaisedButton(
                onPressed: () {},
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
