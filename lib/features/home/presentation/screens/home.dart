import 'dart:async';

import 'package:bash_gid/components/search_textfield.dart';

import 'package:bash_gid/core/authorization.dart';
import 'package:bash_gid/core/database.dart';
import 'package:bash_gid/features/activity/presentation/screens/activity.dart';
import 'package:bash_gid/features/home/data/models/places.dart';
import 'package:bash_gid/features/filter/presentation/screens/filter_page.dart';
import 'package:bash_gid/features/info/presentation/screens/info.dart';
import 'package:bash_gid/features/item_detail_info/presentation/screens/detail_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../components/bottom_sheet_menu.dart';
import '../../../filter/data/models/filters.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DataBaseService _dataBaseService = DataBaseService();
  final TextEditingController _searchController = TextEditingController();

  int indexCurrentNavBar = 0;
  String _searchQuery = '';
  List<Places> _placesList = [];
  List<Places> _resultsList = [];
  bool switchState = false;
  String switchName = '';

  final List<Filters> _sightFiltersList = [
    Filters(filterName: 'Национальный парк', filterState: false),
    Filters(filterName: 'Памятник', filterState: false),
    Filters(filterName: 'Место исторического события', filterState: false),
    Filters(filterName: 'Зоопарк', filterState: false),
    Filters(filterName: 'Музей', filterState: false),
    Filters(filterName: 'Галлерея', filterState: false),
    Filters(filterName: 'Ботанический сад', filterState: false),
    Filters(filterName: 'Парк развлечений', filterState: false),
    Filters(filterName: 'Культурное событие', filterState: false),
    Filters(filterName: 'Карнавал', filterState: false),
    Filters(filterName: 'Ярмарка', filterState: false),
  ];

  final List<Filters> _hotelsFiltersList = [
    Filters(filterName: 'Отель', filterState: false),
    Filters(filterName: 'Бизнес-отель', filterState: false),
    Filters(filterName: 'Хостел', filterState: false),
    Filters(filterName: 'Мотель', filterState: false),
    Filters(filterName: 'Гестхаус', filterState: false),
  ];

  final List<Filters> _foodsFiltersList = [
    Filters(filterName: 'Кафе', filterState: false),
    Filters(filterName: 'Ресторан', filterState: false),
    Filters(filterName: 'Фаст-фуд', filterState: false),
  ];

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose(){
    _searchController.dispose();
    super.dispose();
  }

  void _logOut(){
    Navigator.pop(context);
    AuthService().logOut();
  }

  void _filterPageRedirect(){
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FilterPage(),
        )
    );
  }

  void _informationPageRedirect(){
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InfoPage(),
        )
    );
  }

  _activityPageRedirect(){
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ActivityPage(),
        )
    );
  }

  List<Places> _search(List<Places>? place) {
    if(_searchQuery.isNotEmpty == true) {
      //search logic what you want
      return place?.where((element) => element.placeName.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList() ?? <Places>[];
    }

    return place ?? <Places>[];
  }

  List<Places> _filter (List<Places>? place, String filterName, bool state){
    if(state == true) {
      return place?.where((element) => element.placeType.any((element) => element.toLowerCase().contains(filterName.toLowerCase())))
          .toList() ?? <Places>[];
    }

    return place ?? <Places>[];
  }

  @override
  Widget build(BuildContext context) {

    Widget _bottomSheetFilters(BuildContext context, List<Filters> list) {
      return Container(
        color: const Color(0xFF737373),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              )
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Container(
                  height: 5,
                  width: MediaQuery.of(context).size.width/7,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                ),
              ),
              Row(
                children: [
                  const Spacer(),
                  TextButton(
                      onPressed: (){
                      },
                      child: const Text('Сбросить')
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 20),
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: Card(
                          elevation: 2.0,
                          child: Container(
                            decoration: const BoxDecoration(color: Color.fromRGBO(144, 188, 218, 1.0)),
                            child: SwitchListTile.adaptive(
                              title: Text(list[index].filterName),
                              value: list[index].filterState,
                              onChanged: (value){
                                setState(() {
                                  list[index].filterState = value;
                                  switchState = value;
                                  switchName = list[index].filterName;
                                  //_filter(_resultsList, list[index].filterName, list[index].filterState);
                                });
                              },
                            )
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget searchTextField(BuildContext context, Icon icon, String hint, TextEditingController controller, bool obscure){
      return Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: TextField(
            controller: controller,
            obscureText: obscure,
            onChanged: (value){
              setState(() {
                _searchQuery = value;
              });
            },
            style: const TextStyle(fontSize: 20, color: Colors.black,),
            decoration: InputDecoration(
                fillColor: const Color.fromRGBO(144, 188, 218, 1.0),
                filled: true,
                hintStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black87),
                hintText: hint,
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 3,
                    )
                ),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black54,
                      width: 1,
                    )
                ),
                prefixIcon: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // added line
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        icon: const Icon(Icons.menu),
                        iconSize: 25,
                        color: Colors.black54,
                        onPressed: (){
                          showModalBottomSheet(
                              context: context,
                              builder: (context)
                              {
                                //second parameter: widget.user.email!
                                return bottomSheetMenu(context, widget.user.email!, (){}, _informationPageRedirect, _logOut, _activityPageRedirect);
                              });
                        }),
                    IconButton(
                        icon: const Icon(FontAwesomeIcons.filter),
                        iconSize: 25,
                        color: Colors.black54,
                        onPressed: (){
                          //_filterPageRedirect();
                          showModalBottomSheet(
                              context: context,
                              builder: (context)
                              {
                                return (indexCurrentNavBar == 0 ? _bottomSheetFilters(context, _sightFiltersList) :
                                (indexCurrentNavBar == 1) ? _bottomSheetFilters(context, _hotelsFiltersList) :
                                _bottomSheetFilters(context, _foodsFiltersList));
                              });
                          //openFilterDialog();
                        }),
                  ],
                ),
                suffixIcon: Container(
                  //padding: EdgeInsets.only(left: 10, right: 10),
                  child: const Icon(
                    FontAwesomeIcons.magnifyingGlass,
                    size: 25,
                    color: Colors.black54,
                  ),
                )
            ),
          ),
        ),
      );
    }

    return Container(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          //toolbarHeight: 15,
          title: const Text('BashGid'),
          leading: const Icon(Icons.explore),
        ),
        body: Column(
          children: <Widget>[
            // SEARCH TEXT FIELD
            searchTextField(context, const Icon(Icons.search), 'Поиск', _searchController, false),

            /* --------------------------------
                GET DATA WITH FUTUREBUILDER IN GRIDVIEW
            ----------------------------------- */
            FutureBuilder(
              future: (indexCurrentNavBar == 0 ? _dataBaseService.getPlacesSights() :
                        (indexCurrentNavBar == 1) ? _dataBaseService.getPlacesHotels() :
                        _dataBaseService.getPlacesFoods()),
                builder: (context, AsyncSnapshot snapshot){
                _placesList = snapshot.data;
                //_resultsList = _search(_placesList);
                _searchQuery.isEmpty ? _resultsList = _filter(_placesList, switchName, switchState) : _resultsList = _search(_placesList);
                //_resultsList = _filter(_placesList, 'ресторан', true);

                  if(!snapshot.hasData || snapshot.hasError || snapshot.connectionState == ConnectionState.waiting) {
                    const Center(child: CircularProgressIndicator());
                  }else if(snapshot.hasData) {
                    return Expanded(
                                  child: GridView.builder(
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 5,
                                          mainAxisSpacing: 5
                                      ),
                                    itemCount: _resultsList.length,
                                    itemBuilder: (context, index){
                                      return buildPlace(_resultsList, index);
                                    },
                                  ),
                              );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
            ),

          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.landmark),
              label: 'Достопримечательности'),
            BottomNavigationBarItem(
                icon: Icon(Icons.hotel),
                label: 'Отели'),
            BottomNavigationBarItem(
                icon: Icon(Icons.restaurant),
                label: 'Еда'),
            // BottomNavigationBarItem(
            //     icon: Icon(FontAwesomeIcons.clockRotateLeft),
            //     label: 'История'),
          ],
          backgroundColor: const Color.fromRGBO(144, 188, 218, 1.0),
          currentIndex: indexCurrentNavBar,
          selectedItemColor: const Color.fromRGBO(18, 153, 132, 1.0),
          onTap: (int index){
            setState(() => indexCurrentNavBar = index);
          },
        ),
      ),
    );
  }

  Widget buildPlace(List<Places> places, int index) => InkWell(
    onTap: (){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DetailInfoPage(),
        settings: RouteSettings(
            arguments: places[index],
          )
        ),
      );
    },
    child: Card(
      elevation: 2.0,
      child: Column(
        children: [
          //Image.asset('assets/images/logo.png', height: 150, width: 150,),
          FutureBuilder(
              future: _dataBaseService.getPhotos(places[index].placeImageUrl),
              builder: (context, AsyncSnapshot<String> snapshot){
                if(!snapshot.hasData || snapshot.hasError || snapshot.connectionState == ConnectionState.waiting) {
                  const Center(child: CircularProgressIndicator());
                }else {
                  return Image.network(
                    snapshot.data!, fit: BoxFit.cover,);
                }
                return const Center(child: CircularProgressIndicator());
              }
          ),
          const Spacer(),
          Text(places[index].placeName),
        ],
      ),
    ),
  );

}