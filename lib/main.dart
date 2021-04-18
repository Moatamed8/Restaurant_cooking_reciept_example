import 'dart:ui';

import 'package:flutter/material.dart';
import 'dummy_data.dart';
import 'screens/category_meals_screen.dart';
import 'models/meal.dart';
import 'screens/meal_detail_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/tabs_screen.dart';
import 'screens/fliter.dart';

void main() {
  runApp(MyApp());
}
  Color pr=Color(0xFF131a31);

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

   List<Meal> _avaliableMeals=DUMMY_MEALS;
   List<Meal> _favoriteMeals=[];


   Map<String ,bool>_filters={
    'gluten':false,
    'lactose':false,
    'vegan':false,
    'vegetarian':false,

  };
   void _toggleFilters(String mealId){
    final existingId= _favoriteMeals.indexWhere((meal) => meal.id==mealId);
    if(existingId>=0){
      setState(() {
        _favoriteMeals.removeAt(existingId);
      });
    }else{
    setState(() {
      _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id==mealId));
    });
    }

   }



   void _setFilters(Map<String ,bool>_filtersData){
    setState(() {
      _filters=_filtersData;
      _avaliableMeals = DUMMY_MEALS.where((meal) {
        if(_filters['gluten'] && !meal.isGlutenFree){
          return false;
        }
        if(_filters['lactose'] && !meal.isLactoseFree){
          return false;
        }
        if(_filters['vegan'] && !meal.isVegan){
          return false;
        }
        if(_filters['vegetarian'] && !meal.isVegetarian){
          return false;
        }

      return true;}).toList();
    });


  }

  bool isMealFavorite(String mealId){
     return _favoriteMeals.any((meal) => meal.id==mealId);
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255,254,229,1),
        textTheme: ThemeData.light().textTheme.copyWith(
          body1:TextStyle (
            color: Color.fromRGBO(20,50,50,1),
          ),
          body2:TextStyle (
            color: Color.fromRGBO(20,50,50,1),
          ),
          title:TextStyle (
            fontSize: 24,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          ),

        ),
      ),
      routes: {
        '/':(context) => TabsScreen(_favoriteMeals),
        CategoryMealScreen.routeName:(context)=> CategoryMealScreen(_avaliableMeals),
        MealDetailScreen.routeName:(context)=> MealDetailScreen(_toggleFilters,isMealFavorite),
        FliterScreen.routeName:(context)=>FliterScreen(_filters,_setFilters),
      },

  //    home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meal App"),
        backgroundColor: pr,
        brightness: Brightness.dark,

      ),
      body: CategoriesScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
