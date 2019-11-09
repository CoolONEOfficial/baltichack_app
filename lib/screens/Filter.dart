import 'package:flutter/material.dart';

class ScreenFilterArgs {
  final Map<String, dynamic> filters;

  ScreenFilterArgs(this.filters);
}

class ScreenFilter extends StatefulWidget {
  static const route = '/screens/filter';

  final ScreenFilterArgs args;

  const ScreenFilter(this.args, {Key key}) : super(key: key);

  @override
  _ScreenFilterState createState() => _ScreenFilterState();
}

class _ScreenFilterState extends State<ScreenFilter> {
  ScreenFilterArgs get args => ModalRoute.of(context).settings.arguments;

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Container(),
    );
  }
}
