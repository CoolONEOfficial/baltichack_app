import 'package:baltichack_app/models/Place.dart';
import 'package:baltichack_app/screens/Place.dart';
import 'package:baltichack_app/widgets/PlaceCard.dart';
import 'package:baltichack_app/widgets/PlaceCardFake.dart';
import 'package:flutter/material.dart';

class ScreenHomeArgs {}

class ScreenHome extends StatefulWidget {
  static const route = '/screens/home';

  @override
  _ScreenHomeState createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  List tabs = ['my', 'friends', 'all'];

  List gifs = List.generate(5, (i) => 'assets/gifs/${i + 1}.gif');

  static const List videos = [
    'https://file-examples.com/wp-content/uploads/2017/04/file_example_MP4_480_1_5MG.mp4',
    'https://file-examples.com/wp-content/uploads/2017/04/file_example_MP4_640_3MG.mp4'
  ];

  bool selectedPlace = false;

  static const startPage = 1;
  List<PlaceCard> pages = List.generate(
      videos.length,
      (i) => PlaceCard(
            autoplay: i == startPage,
            videoUrl: videos[i],
          ));
  int prevPage = -1;

  Route _createRoute(ScreenPlaceArgs args) {
    return PageRouteBuilder(
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        onPageChanged: (i) {
          if (prevPage != -1) pages[prevPage].controller.pause();
          prevPage = i;
          setState(() {
            pages[i].controller.play();
          });
        },
        itemCount: pages.length,
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
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.push(
                            ctx,
                            _createRoute(ScreenPlaceArgs(Place(
                              'Кафе ресторан рога и копыта',
                              'В этой замечательной экспозиции была представлена новая пушкинская  коллекция, собранная к тому времени сотрудникаВ этой замечательной экспозиции была представлена новая пушкинская  коллекция, собранная к тому времени сотрудникаВ этой замечательной экспозиции была представлена новая пушкинская  коллекция, собранная к тому времени сотрудникаВ этой замечательной экспозиции была представлена новая пушкинская  коллекция, собранная к тому времени сотрудникаВ этой замечательной экспозиции была представлена новая пушкинская  коллекция, собранная к тому времени сотрудникаВ этой замечательной экспозиции была представлена новая пушкинская  коллекция, собранная к тому времени сотрудникаВ этой замечательной экспозиции была представлена новая пушкинская  коллекция, собранная к тому времени сотрудникаВ этой замечательной экспозиции была представлена новая пушкинская  коллекция, собранная к тому времени сотрудниками музея. Она составила основу московской пушкинианы.',
                              TimeOfDay.now(),
                              TimeOfDay.now(),
                              'https://file-examples.com/wp-content/uploads/2017/04/file_example_MP4_480_1_5MG.mp4',
                            ))));
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
      ),
//            FutureBuilder(
//              future: http.get('https://marine-brief.herokuapp.com/greeting'),
//              builder: (ctx, ss) => Text(
//                  ss.connectionState == ConnectionState.done ? (ss.data as http.Response).body : '...'),
//            ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
