import 'package:baltichack_app/screens/Filter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ScreenHomeArgs {}

class ScreenHome extends StatefulWidget {
  static const route = '/screens/home';

  @override
  _ScreenHomeState createState() => _ScreenHomeState();
}

class Pref {
  final String image;
  final String name;

  const Pref(this.image, this.name);
}

enum FilterType {
  Check,
  Radio,
  DialogNumber,
  DialogChecks,
  DialogRadios,
}

class DataDialogRadios {
  Filter selected;
  final List<Filter> filters;

  DataDialogRadios(this.filters);
}

class DataRadio {
  final Image image;
  final String value;
  bool checked;

  DataRadio(this.image, this.value);
}

class DataCheck {
  final Image image;
  bool checked = false;

  DataCheck(this.image);
}

class Filter {
  final String name;
  final FilterType type;
  final dynamic data;

  Filter(this.name, this.type, this.data);
}

Map<Pref, List<Filter>> prefs = {
  Pref('culture', 'Культура'): [],
  Pref('food', 'Поесть'): [
    Filter('Кухня', FilterType.DialogChecks, [
      Filter('Казахская', FilterType.Check, DataCheck(Image.asset(''))),
      Filter('Русская', FilterType.Check, DataCheck(Image.asset(''))),
      Filter('Питерская', FilterType.Check, DataCheck(Image.asset(''))),
      Filter('Европейская', FilterType.Check, DataCheck(Image.asset(''))),
    ]),
    Filter(
        'Вы придете',
        FilterType.DialogRadios,
        DataDialogRadios([
          Filter('Один', FilterType.Radio, DataRadio(Image.asset(''), 'alone')),
          Filter('Компанией', FilterType.Radio,
              DataRadio(Image.asset(''), 'team')),
          Filter('С ребенком', FilterType.Radio,
              DataRadio(Image.asset(''), 'baby')),
        ])),
    Filter(
        'Расположение',
        FilterType.DialogRadios,
        DataDialogRadios([
          Filter('Городские', FilterType.Radio,
              DataRadio(Image.asset(''), 'in_city')),
          Filter('За городом', FilterType.Radio,
              DataRadio(Image.asset(''), 'out_city')),
        ])),
    Filter('Вегетарианское меню', FilterType.Check, DataCheck(Image.asset(''))),
    Filter('Постное меню', FilterType.Check, DataCheck(Image.asset(''))),
    Filter('Игровая комната', FilterType.Check, DataCheck(Image.asset(''))),
    Filter('Живая музыка', FilterType.Check, DataCheck(Image.asset(''))),
  ],
  Pref('learning', 'Образование'): [
    Filter('Направление', FilterType.DialogChecks, [
      Filter('Бизнес', FilterType.Check, DataCheck(Image.asset(''))),
      Filter('Творчество', FilterType.Check, DataCheck(Image.asset(''))),
      Filter('Коммуникация', FilterType.Check, DataCheck)
    ]),
    Filter(
        'Посещение',
        FilterType.DialogRadios,
        DataDialogRadios([
          Filter(
              'Платное', FilterType.Radio, DataRadio(Image.asset(''), 'pay')),
          Filter('Бесплатное', FilterType.Radio,
              DataRadio(Image.asset(''), 'free')),
        ])),
  ],
  Pref('parties', 'Вечеринки'): [
    Filter(
        'Спортивные трансляции', FilterType.Check, DataCheck(Image.asset(''))),
    Filter('Кальян', FilterType.Check, DataCheck(Image.asset(''))),
    Filter('Своя пивоварня', FilterType.Check, DataCheck(Image.asset(''))),
    Filter('Караоке', FilterType.Check, DataCheck(Image.asset(''))),
    Filter('Vip-зоны', FilterType.Check, DataCheck(Image.asset(''))),
    Filter('Бильярд', FilterType.Check, DataCheck(Image.asset(''))),
  ],
  Pref('nature', 'Отдых на природе'): [
    Filter(
        'Жилье',
        FilterType.DialogRadios,
        DataDialogRadios([
          Filter(
              'Палатка', FilterType.Radio, DataRadio(Image.asset(''), 'tent')),
          Filter(
              'Домик', FilterType.Radio, DataRadio(Image.asset(''), 'house')),
        ])),
    Filter('Караоке', FilterType.Check, DataCheck(Image.asset(''))),
    Filter('Парковка', FilterType.Check, DataCheck(Image.asset(''))),
    Filter('Охрана', FilterType.Check, DataCheck(Image.asset(''))),
    Filter('Бильярд', FilterType.Check, DataCheck(Image.asset(''))),
  ],
  Pref('water', 'На воде'): [],
  Pref('culture', 'Добро'): [],
  Pref('culture', 'Доступная среда'): [],
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

  Route _createRoute(ScreenFilterArgs args) => PageRouteBuilder(
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
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text('Colections'),
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
                            child: Container(
                              width: 165,
                              height: 155,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    debugPrint('dsfdsfds');
                                    Navigator.push(
                                        ctx,
                                        _createRoute(
                                            ScreenFilterArgs(entry.value)));
                                  },
                                  child: Image(
                                    width: 165.0,
                                    height: 165.0,
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
