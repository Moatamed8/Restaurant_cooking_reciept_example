import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:my_meal/Providers/language_provider.dart';
import 'package:my_meal/Providers/meal_provider.dart';
import 'package:my_meal/Providers/theme_provider.dart';
import 'package:provider/provider.dart';

import '../screens/categories_screen.dart';
import '../screens/favorites_screen.dart';
import '../widget/main_drawer.dart';

Color pr = Color(0xff131a31);

class TabsScreen extends StatefulWidget {
  static const routeName = "tab_screen";

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;

  @override
  initState() {
    Provider.of<MealProvider>(context, listen: false).getValues();
    Provider.of<ThemeProvider>(context, listen: false).getThemeMode();
    Provider.of<ThemeProvider>(context, listen: false).getThemeColor();
    Provider.of<LanguageProvider>(context, listen: false).getLan();

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
    var lan = Provider.of<LanguageProvider>(context, listen: true);

    _pages = [
      {
        'page': CategoriesScreen(),
        'title': lan.getTexts('categories'),
      },
      {
        'page': FavoritesScreen(),
        'title': lan.getTexts('your_favorites'),
      },
    ];
    var primaryColor = Provider.of<ThemeProvider>(context).primaryColor;
    var accentColor = Provider.of<ThemeProvider>(context).accentColor;

    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_pages[_selectPagesIndex]['title']),
          brightness: Brightness.dark,
        ),
        body: _pages[_selectPagesIndex]['page'],
        bottomNavigationBar: FFNavigationBar(
          onSelectTab: _SelectPages,
          selectedIndex: _selectPagesIndex,
          theme: FFNavigationBarTheme(
            barBackgroundColor: primaryColor,
            selectedItemBackgroundColor: accentColor,
            selectedItemIconColor: Colors.white,
            selectedItemLabelColor: Colors.grey,
          ),
          items: [
            FFNavigationBarItem(
                iconData: Icons.category, label: lan.getTexts('categories')),
            FFNavigationBarItem(
                iconData: Icons.favorite,
                label: lan.getTexts('your_favorites')),
            // FFNavigationBarItem(iconData: Icons.settings,label: "Filters"),
          ],
        ),
        drawer: MainDrawer(),
      ),
    );
  }
}
