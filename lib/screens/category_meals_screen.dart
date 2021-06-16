import 'package:flutter/material.dart';
import 'package:my_meal/Providers/language_provider.dart';
import 'package:my_meal/Providers/meal_provider.dart';
import 'package:my_meal/models/meal.dart';
import '../widget/meal_item.dart';
import 'package:provider/provider.dart';

class CategoryMealScreen extends StatefulWidget {
  static const routeName = "category_meal_screen";

  @override
  _CategoryMealState createState() => _CategoryMealState();
}

class _CategoryMealState extends State<CategoryMealScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;
  var categoryId;

  @override
  void didChangeDependencies() {
    final List<Meal> _avaliableMeals =
        Provider.of<MealProvider>(context).availableMeals;
    //that routeArg for recieve data send while pushnamed
    final routeArg =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    categoryId = routeArg['id'];
    // widget cuz is public for all and where for check for meal data that contain every this category id using where
    displayedMeals = _avaliableMeals.where((element) {
      return element.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  void removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((element) => element.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    var wd = MediaQuery.of(context).size.width;
    bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          title: Text(lan.getTexts('cat-$categoryId')),
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: wd <= 400 ? 400 : 500,
            childAspectRatio: isLandScape ? wd / (wd * .69) : wd / (wd * .715),
            // for each item will 3rd 400*2.4  and hight 400*2
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
          ),
          // you need list all items list view with item count list lenght will show
          itemBuilder: (ctx, index) {
            // index instead of id
            return MealItem(
              displayedMeals[index].id,
              displayedMeals[index].imageUrl,
              displayedMeals[index].duration,
              displayedMeals[index].complexity,
              displayedMeals[index].affordability,
            );
          },
          itemCount: displayedMeals.length,
        ),
      ),
    );
  }
}
