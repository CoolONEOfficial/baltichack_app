import 'dart:math';

import 'package:baltichack_app/screens/Catalog.dart';
import 'package:baltichack_app/screens/Filter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Home.g.dart';

class ScreenHomeArgs {}

class ScreenHome extends StatefulWidget {
  static const route = '/screens/home';

  @override
  _ScreenHomeState createState() => _ScreenHomeState();
}

@JsonSerializable(nullable: false)
class Pref {
  final String image;
  final String name;

  const Pref(this.image, this.name);

  factory Pref.fromJson(Map<String, dynamic> json) => _$PrefFromJson(json);

  Map<String, dynamic> toJson() => _$PrefToJson(this);
}

enum FilterType {
  Check,
  Radio,
  DialogNumber,
  DialogChecks,
  DialogRadios,
}

@JsonSerializable(nullable: false)
class DataDialogRadios {
  Filter selected;
  final List<Filter> filters;

  DataDialogRadios(this.filters);

  factory DataDialogRadios.fromJson(Map<String, dynamic> json) =>
      _$DataDialogRadiosFromJson(json);

  Map<String, dynamic> toJson() => _$DataDialogRadiosToJson(this);
}

@JsonSerializable(nullable: false)
class DataDialogNumber {
  int number;

  DataDialogNumber();

  factory DataDialogNumber.fromJson(Map<String, dynamic> json) =>
      _$DataDialogNumberFromJson(json);

  Map<String, dynamic> toJson() => _$DataDialogNumberToJson(this);
}

@JsonSerializable(nullable: false)
class DataRadio {
  @JsonKey(ignore: true)
  Image image;
  final String value;
  bool checked;

  DataRadio(this.value, {this.image});

  factory DataRadio.fromJson(Map<String, dynamic> json) =>
      _$DataRadioFromJson(json);

  Map<String, dynamic> toJson() => _$DataRadioToJson(this);
}

@JsonSerializable(nullable: false)
class DataCheck {
  @JsonKey(ignore: true)
  Image image;
  bool checked = false;

  DataCheck({this.image});

  factory DataCheck.fromJson(Map<String, dynamic> json) =>
      _$DataCheckFromJson(json);

  Map<String, dynamic> toJson() => _$DataCheckToJson(this);
}

@JsonSerializable(nullable: false)
class Filter {
  final String name;
  final FilterType type;
  final dynamic data;

  Filter(this.name, this.type, this.data);

  factory Filter.fromJson(Map<String, dynamic> json) => _$FilterFromJson(json);

  Map<String, dynamic> toJson() => _$FilterToJson(this);
}

Map<Pref, List<Filter>> prefs = {
  Pref('culture', 'Культура'): [],
  Pref('food', 'Поесть'): [
    Filter('Кухня', FilterType.DialogChecks, [
      Filter('Казахская', FilterType.Check, DataCheck()),
      Filter('Русская', FilterType.Check, DataCheck()),
      Filter('Питерская', FilterType.Check, DataCheck()),
      Filter('Европейская', FilterType.Check, DataCheck()),
    ]),
    Filter('Вы придете', FilterType.DialogNumber, DataDialogNumber()),
    Filter(
        'Расположение',
        FilterType.DialogRadios,
        DataDialogRadios([
          Filter('Городские', FilterType.Radio, DataRadio('in_city')),
          Filter('За городом', FilterType.Radio, DataRadio('out_city')),
        ])),
    Filter('Вегетарианское меню', FilterType.Check, DataCheck()),
    Filter('Постное меню', FilterType.Check, DataCheck()),
    Filter('Игровая комната', FilterType.Check, DataCheck()),
    Filter('Живая музыка', FilterType.Check, DataCheck()),
  ],
  Pref('learning', 'Образование'): [
    Filter('Направление', FilterType.DialogChecks, [
      Filter('Бизнес', FilterType.Check, DataCheck()),
      Filter('Творчество', FilterType.Check, DataCheck()),
      Filter('Коммуникация', FilterType.Check, DataCheck)
    ]),
    Filter(
        'Посещение',
        FilterType.DialogRadios,
        DataDialogRadios([
          Filter('Платное', FilterType.Radio, DataRadio('pay')),
          Filter('Бесплатное', FilterType.Radio, DataRadio('free')),
        ])),
  ],
  Pref('parties', 'Вечеринки'): [
    Filter('Спортивные трансляции', FilterType.Check, DataCheck()),
    Filter('Кальян', FilterType.Check, DataCheck()),
    Filter('Своя пивоварня', FilterType.Check, DataCheck()),
    Filter('Караоке', FilterType.Check, DataCheck()),
    Filter('Vip-зоны', FilterType.Check, DataCheck()),
    Filter('Бильярд', FilterType.Check, DataCheck()),
  ],
  Pref('nature', 'Отдых на природе'): [
    Filter(
        'Жилье',
        FilterType.DialogRadios,
        DataDialogRadios([
          Filter('Палатка', FilterType.Radio, DataRadio('tent')),
          Filter('Домик', FilterType.Radio, DataRadio('house')),
        ])),
    Filter('Караоке', FilterType.Check, DataCheck()),
    Filter('Парковка', FilterType.Check, DataCheck()),
    Filter('Охрана', FilterType.Check, DataCheck()),
    Filter('Бильярд', FilterType.Check, DataCheck()),
  ],
  Pref('water', 'На воде'): [],
  Pref('vol', 'Добро'): [],
  Pref('eco', 'Экология'): [],
};

class _ScreenHomeState extends State<ScreenHome> {
  ScreenHomeArgs get args => ModalRoute.of(context).settings.arguments;

  PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void navigationTapped(int page) {
    // Animating to the page.
    // You can use whatever duration and curve you like
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  Route createRouteFilter(ScreenFilterArgs args) => PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ScreenFilter(args),
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

  @override
  Widget build(BuildContext ctx) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(241, 242, 242, 1.0),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text('Collections'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.search, color: Color.fromRGBO(0, 0, 0, 0.5)),
            onPressed: () {
              // TODO: search
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add, color: Color.fromRGBO(0, 0, 0, 0.5)),
              onPressed: () {
                // TODO: search
              },
            )
          ],
        ),
        body: PageView(
          onPageChanged: onPageChanged,
          controller: _pageController,
          children: [
            ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                CarouselSlider(
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayInterval: Duration(seconds: 4),
                  viewportFraction: 1.0,
                  height: 180.0,
                  items: [1, 2, 3, 4, 5]
                      .map((i) => Builder(
                            builder: (BuildContext context) => ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/gifs/' + i.toString() + '.gif',
                                height: 180.0,
                                fit: BoxFit.cover,
                                width: MediaQuery.of(ctx).size.width - 30,
                              ),
                            ),
                          ))
                      .toList(),
                ),
                Padding(
                  padding: const EdgeInsets.all(7.5),
                  child: GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    children: prefs.entries
                        .map(
                          (entry) => Padding(
                            padding: const EdgeInsets.all(7.5),
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              fit: StackFit.expand,
                              children: <Widget>[
                                Container(
                                  width: 165,
                                  height: 155,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: GestureDetector(
                                      onTap: () => Navigator.push(
                                          ctx,
                                          entry.value.isEmpty
                                              ? ScreenCatalog
                                                  .createRouteCatalog(
                                                      ScreenCatalogArgs(entry))
                                              : createRouteFilter(
                                                  ScreenFilterArgs(entry))),
                                      child: Image(
                                        width: 165.0,
                                        height: 155.0,
                                        image: AssetImage(
                                          'assets/images/' +
                                              entry.key.image +
                                              '.jpeg',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  width: 172,
                                  bottom: -4,
                                  child: Card(
                                    elevation: 0,
                                    color: Colors.black,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        entry.key.name,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 17),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                )
              ],
            ),
            Container(
              color: Colors.orange,
            ),
            Container(
              color: Colors.lightGreen,
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              title: Text('Business'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              title: Text('School'),
            ),
          ],
          onTap: navigationTapped,
          currentIndex: _page,
        ),
      ),
    );
  }
}
