import 'package:flutter/material.dart';

enum Complexity {
  Simple,
  Challenging,
  Hard,

}
enum Affordability {
  Affordable,
  Pricey,
  Luxurious
}

class Meal {
  final String id;
  final List<String> categories;
  final String title;

  final String imageUrl;
  final int duration;
  final List<String> ingredients;
  final List<String> steps;
  final Complexity complexity;
  final Affordability affordability;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;

  const Meal({@required this.id,@required this.categories,@required this.title,@required this.imageUrl,@required this.duration,
    @required this.ingredients,@required this.steps,@required this.complexity,@required this.affordability,
    @required this.isGlutenFree,@required this.isLactoseFree,@required this.isVegan,@required this.isVegetarian});


}