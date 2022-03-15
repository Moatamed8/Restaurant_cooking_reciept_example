import 'package:flutter/material.dart';
import 'package:my_meal/Providers/language_provider.dart';
import 'package:my_meal/Providers/meal_provider.dart';
import 'package:my_meal/Providers/theme_provider.dart';
import 'package:my_meal/widget/main_drawer.dart';
import 'package:provider/provider.dart';

class FliterScreen extends StatefulWidget {
  static const routeName = 'fliter_screen';

  final bool fromOnBoarding;

  FliterScreen({this.fromOnBoarding = false});

  @override
  _FliterScreenState createState() => _FliterScreenState();
}

class _FliterScreenState extends State<FliterScreen> {
  Widget buildSwitchListTile(
      String title, String subTitle, bool value, Function function) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subTitle),
      value: value,
      onChanged: function,
      activeColor: ThemeProvider.of(context, listen: true)
          .accentColor,
      inactiveTrackColor:
      ThemeProvider.of(context, listen: true).tm ==
                  ThemeMode.light
              ? null
              : Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, bool> currentFilter =
        MealProvider.of(context, listen: true).filters;
    var lan = LanguageProvider.of(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: widget.fromOnBoarding
            ? AppBar(
                backgroundColor: Theme.of(context).canvasColor,
                elevation: 0,
              )
            : AppBar(
                brightness: Brightness.dark,
                title: Text(lan.getTexts('filters_appBar_title')),
              ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                lan.getTexts('filters_screen_title'),
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  buildSwitchListTile(
                      lan.getTexts('Gluten-free'),
                      lan.getTexts('Gluten-free-sub'),
                      currentFilter['gluten'], (newValue) {
                    setState(() {
                      currentFilter['gluten'] = newValue;
                    });
                    MealProvider.of(context, listen: false)
                        .setFilters();
                  }),
                  buildSwitchListTile(
                      lan.getTexts('Lactose-free'),
                      lan.getTexts('Lactose-free_sub'),
                      currentFilter['lactose'], (newValue) {
                    setState(() {
                      currentFilter['lactose'] = newValue;
                    });
                    MealProvider.of(context, listen: false)
                        .setFilters();
                  }),
                  buildSwitchListTile(
                      lan.getTexts('Vegan'),
                      lan.getTexts('Vegan-sub'),
                      currentFilter['vegan'], (newValue) {
                    setState(() {
                      currentFilter['vegan'] = newValue;
                    });
                    MealProvider.of(context, listen: false)
                        .setFilters();
                  }),
                  buildSwitchListTile(
                      lan.getTexts('Vegetarian'),
                      lan.getTexts('Vegetarian-sub'),
                      currentFilter['vegetarian'], (newValue) {
                    setState(() {
                      currentFilter['vegetarian'] = newValue;
                    });
                    MealProvider.of(context, listen: false)
                        .setFilters();
                  }),
                ],
              ),
            ),
          ],
        ),
        drawer: widget.fromOnBoarding ? null : MainDrawer(),
      ),
    );
  }
}
