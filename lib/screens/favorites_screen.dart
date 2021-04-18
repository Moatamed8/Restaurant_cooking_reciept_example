import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widget/meal_item.dart';
class FavoritesScreen extends StatelessWidget {
  final List<Meal> _favoriteMeals;


  FavoritesScreen(this._favoriteMeals);
  @override
  Widget build(BuildContext context) {
    if(_favoriteMeals.isEmpty){
      return Center(
        child: Text("You have no favorites yet -start adding some!"),
      );

    }
    else {
      return  ListView.builder(
        itemBuilder: (ctx, index) {
          // index instead of id
          return MealItem(
              _favoriteMeals[index].id,
              _favoriteMeals[index].title,
              _favoriteMeals[index].imageUrl,
              _favoriteMeals[index].duration,
              _favoriteMeals[index].complexity,
              _favoriteMeals[index].affordability);
        },
        itemCount: _favoriteMeals.length,
      );
    }


  }
}
