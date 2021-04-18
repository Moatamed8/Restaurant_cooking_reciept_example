import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:my_meal/models/meal.dart';
import '../screens/categories_screen.dart';
import '../screens/favorites_screen.dart';
import '../widget/main_drawer.dart';


class TabsScreen extends StatefulWidget {

  final List<Meal> _favoriteMeals;
  Map<String, bool>_filtersData;
  Function _filter;


  TabsScreen(this._favoriteMeals);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

Color pr = Color(0xff131a31);

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;

  @override
  initState() {
    _pages = [
      {
        'page': CategoriesScreen(),
        'title': 'Categories',
      },
      {
        'page': FavoritesScreen(widget._favoriteMeals),
        'title': 'Your Favorites'
      },

    ];
    super.initState();
  }

  int _selectPagesIndex = 0;

  void _SelectPages(int value) {
    setState(() {
      _selectPagesIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectPagesIndex]['title']),
        backgroundColor: pr,
        brightness: Brightness.dark,

      ),
      body: _pages[_selectPagesIndex]['page'],

      bottomNavigationBar: FFNavigationBar(
        onSelectTab: _SelectPages,
        selectedIndex: _selectPagesIndex,
        theme: FFNavigationBarTheme(
          barBackgroundColor: Color.fromRGBO(255, 254, 229, 1),
          selectedItemBackgroundColor: Colors.amber,
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Colors.grey,

        ),
        items: [
          FFNavigationBarItem(iconData: Icons.category, label: "Categories"),
          FFNavigationBarItem(iconData: Icons.favorite, label: "Favorites"),
          // FFNavigationBarItem(iconData: Icons.settings,label: "Filters"),


        ],

      ),
      drawer: MainDrawer(),
    );
  }
}

