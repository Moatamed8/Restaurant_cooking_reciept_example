import 'package:flutter/material.dart';
import 'package:my_meal/models/meal.dart';
import '../widget/meal_item.dart';

import '../dummy_data.dart';

class CategoryMealScreen extends StatefulWidget {
  static const routeName = "category_meal_screen";
  final List<Meal> _avaliableMeals;


  CategoryMealScreen(this._avaliableMeals);

  @override
  _CategoryMealState createState() => _CategoryMealState();
}



class _CategoryMealState extends State<CategoryMealScreen> {

  String categoryTitle;
  List<Meal> displayedMeals;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    final routeArg = ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryId = routeArg['id'];
    categoryTitle = routeArg['title'];

    displayedMeals = widget._avaliableMeals.where((element) {
      return element.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }


  void removeMeal(String mealId) {
    setState((){
      displayedMeals.removeWhere((element) => element.id==mealId);

    });

  }
  Color pr = Color(0xFF131a31);

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: pr,
        title: Text(categoryTitle),
        brightness: Brightness.dark,
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          // index instead of id
          return MealItem(
              displayedMeals[index].id,
              displayedMeals[index].title,
              displayedMeals[index].imageUrl,
              displayedMeals[index].duration,
              displayedMeals[index].complexity,
              displayedMeals[index].affordability,);
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
