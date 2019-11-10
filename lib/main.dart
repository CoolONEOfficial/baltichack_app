import 'package:baltichack_app/screens/Catalog.dart';
import 'package:baltichack_app/screens/Home.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MarineBrief app',
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromRGBO(241, 242, 242, 1.0),
        canvasColor: Color.fromRGBO(241, 242, 242, 1.0),
        backgroundColor: Color.fromRGBO(241, 242, 242, 1.0),
        primarySwatch: Colors.grey,
        fontFamily: 'Telex'
      ),
      initialRoute: ScreenHome.route,
      routes: {
        ScreenHome.route: (ctx) => ScreenHome()
      },
    );
  }
}
