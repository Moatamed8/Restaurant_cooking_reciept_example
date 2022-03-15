import 'package:flutter/material.dart';
import 'package:my_meal/Providers/meal_provider.dart';
import 'package:my_meal/widget/category_item.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.all(8),
      //check for DUMMY_CATEGORIES catData will check in catagory and return it in CategoryItems that take catData.id, catData.title, catData.color
      children: MealProvider.of(context)
          .availableCategory
          .map(
            (catData) => CategoryItem(catData.id, catData.color),
          )
          .toList(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
    );
  }
}
