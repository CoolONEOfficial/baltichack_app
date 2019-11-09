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
        primarySwatch: Colors.grey,
        fontFamily: 'Tahoma'
      ),
      initialRoute: ScreenHome.route,
      routes: {
        ScreenHome.route: (context) => ScreenHome()
      },
    );
  }
}
