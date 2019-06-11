import 'package:flutter_web/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "https://asciifigure.herokuapp.com/";
// const baseUrl = "http://localhost:8085";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Droid Generator',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  MyHomePage createState() => MyHomePage();
}

class MyHomePage extends State<MainPage> {

  String title = 'Droid generator by Flutter';

  String _droid = "";

  Future<String> getDroid() async {
    http.Response response = await http.get(
      Uri.encodeFull(baseUrl),
      headers: { 
        "Content-Type": "text/plain; charset=utf-8"
      }
    );

    return response.body;
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new FutureBuilder(
                future: getDroid(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return CircularProgressIndicator();
                    default:
                      if (snapshot.hasError)
                        return new Text('Error: ${snapshot.error}');
                      else
                        return new Text(snapshot.data);
                  }
                }),
            new RaisedButton(
                child: new Text("Generate Droid"),
                onPressed: () {
                  setState(() {});
                }),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
