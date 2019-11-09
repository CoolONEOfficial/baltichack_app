import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlaceCard extends StatefulWidget {
  final String videoUrl;
  final bool autoplay;

  PlaceCard({Key key, this.videoUrl, this.autoplay}) : super(key: key);

  VideoPlayerController controller;

  @override
  _PlaceCardState createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCard> {
  @override
  void initState() {
    super.initState();
    widget.controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        widget.controller.setLooping(true);
        if (widget.autoplay) setState(() {});
        // Ensure the first frame is shown after the video is initialized
      });
  }

  @override
  Widget build(BuildContext ctx) {
    return ClipRRect(
      borderRadius: new BorderRadius.circular(30.0),
      child: SizedBox(
        width: 300,
        height: 520,
        child: VideoPlayer(widget.controller),
      ),
    );
  }
}
