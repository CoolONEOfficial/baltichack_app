import 'package:flutter/material.dart';

class PlaceCardFake extends StatefulWidget {
  final String gifUrl;

  const PlaceCardFake({Key key, this.gifUrl}) : super(key: key);

  @override
  _PlaceCardState createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCardFake> {
  @override
  Widget build(BuildContext ctx) {
    return ClipRRect(
      borderRadius: new BorderRadius.circular(30.0),
      child: Image.asset(
        widget.gifUrl,
        height: 520,
        width: 300,
        fit: BoxFit.cover,
      ),
    );
  }
}
