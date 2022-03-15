import 'package:flutter/Material.dart';
import 'package:my_meal/models/category.dart';
import 'package:my_meal/models/meal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../data/dummy_data.dart';

class MealProvider with ChangeNotifier {

  static MealProvider of(BuildContext context, {bool listen = false}) {
    if (listen) return context.watch<MealProvider>();
    return context.read<MealProvider>();
  }

  List<String> prefsMealId = [];
  List<Meal> availableMeals = DUMMY_MEALS;

  List<Meal> favoriteMeals = [];
  List<Category> availableCategory = DUMMY_CATEGORIES;


  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  void toggleFilters(String mealId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final existingId = favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if (existingId >= 0) {
      favoriteMeals.removeAt(existingId);
      prefsMealId.remove(mealId);
    } else {
      favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      prefsMealId.add(mealId);
    }

    notifyListeners();

    prefs.setStringList('prefsId', prefsMealId);
  }


  void setFilters() async {
    availableMeals = DUMMY_MEALS.where((meal) {
      if (filters['gluten'] && !meal.isGlutenFree) {
        return false;
      }
      if (filters['lactose'] && !meal.isLactoseFree) {
        return false;
      }
      if (filters['vegan'] && !meal.isVegan) {
        return false;
      }
      if (filters['vegetarian'] && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();

    List<Category> ac = [];
    availableMeals.forEach((meal) {
      meal.categories.forEach((catId) {
        DUMMY_CATEGORIES.forEach((cat) {
          if (cat.id == catId) {
            if (!ac.any((cat) => cat.id == catId)) ac.add(cat);
          }
        });
      });
    });
    availableCategory = ac;

    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('gluten', filters['gluten']);
    prefs.setBool('lactose', filters['lactose']);
    prefs.setBool('vegan', filters['vegan']);
    prefs.setBool('vegetarian', filters['vegetarian']);
  }
  void getValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    filters['gluten'] = prefs.get('gluten') ?? false;
    filters['lactose'] = prefs.get('lactose') ?? false;
    filters['vegan'] = prefs.get('vegan') ?? false;
    filters['vegetarian'] = prefs.get('vegetarian') ?? false;

    prefsMealId = prefs.getStringList('prefsId') ?? [];

    for (var mealId in prefsMealId) {
      final existingId = favoriteMeals.indexWhere((meal) => meal.id == mealId);

      if (existingId < 0) {
        favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      }
    }
    List<Meal> fm = [];

    favoriteMeals.forEach((favMeals) {
      availableMeals.forEach((avMeal) {
        if (favMeals.id == avMeal.id) fm.add(favMeals);
      });
    });
    favoriteMeals = fm;
    notifyListeners();
  }


  bool isMealFavorite(String mealId) {
    return favoriteMeals.any((meal) => meal.id == mealId);
  }
}
