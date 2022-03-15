import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:my_meal/Providers/language_provider.dart';
import 'package:my_meal/Providers/meal_provider.dart';
import 'package:my_meal/Providers/theme_provider.dart';
import 'package:my_meal/screens/on_boarding_screen.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/category_meals_screen.dart';
import 'screens/meal_detail_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/tabs_screen.dart';
import 'screens/fliter.dart';
import 'screens/theme_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Widget homeScreen =
      prefs.getBool('watched') ?? false ? TabsScreen() : OnBoardingScreen();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: MealProvider()),
      ChangeNotifierProvider.value(value: ThemeProvider()),
      ChangeNotifierProvider.value(value: LanguageProvider()),
    ],
    child: MyApp(homeScreen),
  ));
}

class MyApp extends StatelessWidget {
  final Widget mainScreen;

  MyApp(this.mainScreen);

  @override
  Widget build(BuildContext context) {
    var primaryColor = Provider.of<ThemeProvider>(context).primaryColor;
    var accentColor = Provider.of<ThemeProvider>(context).accentColor;
    var tm = Provider.of<ThemeProvider>(context).tm;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: tm,
      theme: ThemeData(
        primarySwatch: primaryColor,
        accentColor: accentColor,
        canvasColor: Colors.white,
        fontFamily: 'Raleway',
        iconTheme: IconThemeData(color: Colors.black45),
        buttonColor: Colors.black87,
        cardColor: Colors.white60,
        shadowColor: Colors.black45,
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Colors.black45,
              ),
              headline6: TextStyle(
                color: Colors.black87,
                fontSize: 24,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      darkTheme: ThemeData(
        primarySwatch: primaryColor,
        accentColor: accentColor,
        canvasColor: Color.fromRGBO(14, 22, 33, 1),
        fontFamily: 'Raleway',
        iconTheme: IconThemeData(color: Colors.white),
        buttonColor: Colors.white,
        cardColor: Color.fromRGBO(35, 34, 39, 1),
        shadowColor: Colors.white60,
        textTheme: ThemeData.dark().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Colors.white,
              ),
              headline6: TextStyle(
                color: Colors.white70,
                fontSize: 24,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      routes: {
        '/': (context) => mainScreen,
        TabsScreen.routeName: (context) => TabsScreen(),
        CategoryMealScreen.routeName: (context) => CategoryMealScreen(),
        MealDetailScreen.routeName: (context) => MealDetailScreen(),
        FliterScreen.routeName: (context) => FliterScreen(),
        ThemesScreen.routeName: (context) => ThemesScreen(),
      },

      //    home: MyHomePage(),
    );
  }
}
