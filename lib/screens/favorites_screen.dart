import 'package:flutter/material.dart';
import 'package:my_meal/Providers/language_provider.dart';
import 'package:my_meal/Providers/meal_provider.dart';
import 'package:provider/provider.dart';

import '../models/meal.dart';
import '../widget/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var wd = MediaQuery.of(context).size.width;

    final List<Meal> _favoriteMeals =
        Provider.of<MealProvider>(context, listen: true).favoriteMeals;
    if (_favoriteMeals.isEmpty) {
      return Center(
        child: Text(lan.getTexts('favorites_text')),
      );
    } else {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: wd <= 400 ? 400 : 500,
          childAspectRatio: isLandScape ? wd / (wd * .69) : wd / (wd * .715),
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
        ),
        itemBuilder: (ctx, index) {
          // index instead of id
          return MealItem(
              _favoriteMeals[index].id,
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
