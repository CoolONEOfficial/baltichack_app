import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:location/location.dart';
import 'package:baltichack_app/models/Place.dart';
import 'package:baltichack_app/screens/Home.dart';
import 'package:baltichack_app/screens/Place.dart';
import 'package:baltichack_app/widgets/PlaceCard.dart';
import 'package:enhanced_future_builder/enhanced_future_builder.dart';
import 'package:http/http.dart' as http;
import 'package:baltichack_app/widgets/PlaceCardFake.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScreenCatalogArgs {
  final MapEntry<Pref, List<Filter>> filters;

  StateSetter stateSetter;

  ScreenCatalogArgs(this.filters);
}

class ScreenCatalog extends StatefulWidget {
  static Route createRouteCatalog(ScreenCatalogArgs args) => PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        ScreenCatalog(args),
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        ScaleTransition(
          scale: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.fastOutSlowIn,
            ),
          ),
          child: child,
        ),
  );

  static const route = '/screens/catalog';

  final ScreenCatalogArgs args;

  const ScreenCatalog(this.args, {Key key}) : super(key: key);

  @override
  _ScreenCatalogState createState() => _ScreenCatalogState();
}

class _ScreenCatalogState extends State<ScreenCatalog> {
  ScreenCatalogArgs get args => widget.args;

  Random random = new Random();

  List tabs = ['my', 'friends', 'all'];

  List gifs = List.generate(5, (i) => 'assets/gifs/${i + 1}.gif');

  bool selectedPlace = false;

  static const startPage = 1;
  int prevPage = -1;
  List<PlaceCard> pages;

  Route createRoutePlace(ScreenPlaceArgs args) => PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ScreenPlace(args),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return ScaleTransition(
            scale: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              ),
            ),
            child: child,
          );
        },
      );

  Future load() async {
    var completer = new Completer();
    LocationData currentLocation;

    var location = new Location();
    try {
      currentLocation = (await location.getLocation());
    } on Exception catch (e) {
      currentLocation = null;
    }
    debugPrint('current: ' +
        currentLocation.latitude.toString() +
        ', ' +
        currentLocation.longitude.toString());
    final ss = await http.post('https://marine-brief.herokuapp.com/places',
        body: jsonEncode({
          "filter": args.filters.key.name,
          "lat": currentLocation?.latitude ?? 59.883373,
          "lng": currentLocation?.longitude ?? 30.336656,
        }),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });

    int createCounter = -1;
    pages = (json.decode(ss.body)).map<PlaceCard>((mPlace) {
      debugPrint('ddddadadada' + mPlace.toString());
      final Place place = Place.fromJson(mPlace);
      debugPrint('place' + place.toString());
      createCounter++;
      return PlaceCard(
        place,
        autoplay: createCounter == startPage,
        gifUrl: gifs[random.nextInt(gifs.length)],
      );
    }).toList();
    debugPrint('pages: ' + pages.toString());

    // At some time you need to complete the future:
    completer.complete(ss);

    return completer.future;
  }

  Widget buildCatalog(bool loading) => PageView.builder(
        onPageChanged: (i) {
          if (loading) return;
          if (prevPage != -1) pages[prevPage].controller.pause();
          prevPage = i;
          setState(() {
            pages[i].controller.play();
          });
        },
        itemCount: loading ? 3 : pages.length,
        controller: PageController(
          initialPage: startPage,
          viewportFraction: 0.67,
        ),
        itemBuilder: (ctx, i) => Container(
          height: 534,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              Positioned(
                top: 14,
                child: loading
                    ? Stack(
                        alignment: AlignmentDirectional.center,
                        children: <Widget>[
                          PlaceCardFake(
                            gifUrl: gifs[random.nextInt(gifs.length)],
                          ),
                          Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.white,
                            ),
                          )
                        ],
                      )
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            Navigator.push(ctx,
                                createRoutePlace(ScreenPlaceArgs(pages[i].model)));
                          });
                        },
                        child: pages[i]),
              ),
              Positioned(
                top: 14,
                right: 359,
                child: PlaceCardFake(
                  gifUrl: gifs[i % gifs.length],
                ),
              ),
              Positioned(
                top: 14,
                left: 359,
                child: PlaceCardFake(
                  gifUrl: gifs[i % gifs.length],
                ),
              ),
            ],
          ),
        ),
        scrollDirection: Axis.vertical,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EnhancedFutureBuilder(
        future: load(),
        whenActive: buildCatalog(true),
        whenNone: buildCatalog(true),
        whenWaiting: buildCatalog(true),
        whenDone: (_) => buildCatalog(false),
        rememberFutureResult: true,
      ),
    );
  }
}
