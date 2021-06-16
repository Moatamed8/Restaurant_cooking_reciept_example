import 'package:flutter/material.dart';

// we have some of category in data file and want it to list in gridview
class Category {
  final String id;

  final Color color;

  const Category({@required this.id, this.color = Colors.orange});
}
