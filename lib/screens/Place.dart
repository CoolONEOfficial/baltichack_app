import 'package:baltichack_app/models/Place.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ScreenPlaceArgs {
  final Place place;

  ScreenPlaceArgs(this.place);
}

class ScreenPlace extends StatefulWidget {
  static const route = '/screens/place';

  final ScreenPlaceArgs args;
  VideoPlayerController controller;

  ScreenPlace(this.args, {Key key}) : super(key: key);

  @override
  _ScreenPlaceState createState() => _ScreenPlaceState();
}

class _ScreenPlaceState extends State<ScreenPlace> {
  ScreenPlaceArgs get args => widget.args;

  @override
  void initState() {
    super.initState();
    widget.controller = VideoPlayerController.network(args.place.videoUrl);
    widget.controller.initialize().then((_) {
      widget.controller.setLooping(true);
      widget.controller.play();
      setState(() {});
      // Ensure the first frame is shown after the video is initialized
    });
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Center(
            heightFactor: 1,
            child: MaterialButton(
              minWidth: 335,
              height: 47,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide()),
              color: Color.fromRGBO(0, 52, 249, 1),
              child: Text(
                'Find friends',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              onPressed: () {},
            )),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: IconButton(
                icon: Icon(Icons.filter_1),
                onPressed: () {
                  // Do something
                }),
            expandedHeight: 460.0,
            floating: true,
            pinned: true,
            snap: true,
            flexibleSpace:
                FlexibleSpaceBar(background: VideoPlayer(widget.controller)),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text('350 \$', style: TextStyle(fontSize: 30)),
                        SizedBox(height: 17),
                        Text('Cost for 1', style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(children: [
                      Icon(Icons.alarm, size: 32),
                      SizedBox(height: 17),
                      Text('10:00 - 24:00', style: TextStyle(fontSize: 20)),
                    ]),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 20, right: 20),
              child: Text(args.place.description,
                  style: TextStyle(
                    fontSize: 19,
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                  )),
            ),
            SizedBox(height: 47),
          ])),
        ],
      ),
    );
  }
}
