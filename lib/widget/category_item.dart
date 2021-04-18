import 'package:flutter/material.dart';
import '../screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id ;
  final String title;
  final Color color;

  CategoryItem( this.id, this.title, this.color);
  void _selectItem(BuildContext ctx){
    Navigator.pushNamed(ctx, CategoryMealScreen.routeName,
    arguments: {
      'id':id,
      'title':title
    }
    );


  }


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:()=>_selectItem(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Text(title,style: Theme.of(context).textTheme.title,),

        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              color,
              color.withOpacity(.7),
            ],begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

      ),
    );
  }
}
