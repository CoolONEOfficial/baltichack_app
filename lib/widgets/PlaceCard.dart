import 'package:baltichack_app/models/Place.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlaceCard extends StatefulWidget {
  final Place model;
  final bool autoplay;
  final String gifUrl;

  PlaceCard(this.model, {Key key, this.autoplay = false, this.gifUrl})
      : super(key: key);

  VideoPlayerController controller;

  @override
  _PlaceCardState createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCard> {
  @override
  void initState() {
    super.initState();
    widget.controller = VideoPlayerController.network(widget.model.videoUrl)
      ..initialize().then((_) {
        widget.controller.setLooping(true);
        if (widget.autoplay) widget.controller.play();
        setState(() {});
        // Ensure the first frame is shown after the video is initialized
      });
  }

  @override
  Widget build(BuildContext ctx) {
    return ClipRRect(
      borderRadius: new BorderRadius.circular(30.0),
      child: FittedBox(
        fit: BoxFit.contain,
        child: SizedBox(
          width: 300,
          height: 520,
          child: Stack(
            children: <Widget>[
              Image.asset(
                widget.gifUrl,
                fit: BoxFit.cover,
              ),
              VideoPlayer(widget.controller),
            ],
          ),
        ),
      ),
    );
  }
}
