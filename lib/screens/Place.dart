import 'package:baltichack_app/models/Place.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:maps_launcher/maps_launcher.dart';
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
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.transparent,
                expandedHeight: 460.0,
                flexibleSpace: FlexibleSpaceBar(
                    background: VideoPlayer(widget.controller)),
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
                          Image.asset(
                            'assets/icons/clock.png',
                            width: 32,
                            height: 32,
                            fit: BoxFit.fitHeight,
                          ),
                          SizedBox(height: 17),
                          Text(
                              args.place.open.format(ctx) +
                                  ' - ' +
                                  args.place.close.format(ctx),
                              style: TextStyle(fontSize: 20)),
                        ]),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, bottom: 30, right: 20),
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
          Positioned(
            bottom: 20,
            left: (MediaQuery.of(context).size.width / 2) - (335 / 2),
            child: MaterialButton(
              minWidth: 335,
              height: 47,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              color: Color.fromRGBO(0, 52, 249, 1),
              child: Text(
                'Местоположение',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              onPressed: () {
                MapsLauncher.launchCoordinates(args.place.lat, args.place.lng);
              },
            ),
          )
        ],
      ),
    );
  }
}
