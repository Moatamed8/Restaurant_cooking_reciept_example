import 'package:flutter/material.dart';
import 'package:my_meal/main.dart';
import 'package:my_meal/widget/main_drawer.dart';

class FliterScreen extends StatefulWidget {
  static const routeName = 'fliter_screen';
  Function saveFilter;
   Map<String ,bool> currentFilter;

  FliterScreen(this.currentFilter,this.saveFilter,);

  @override
  _FliterScreenState createState() => _FliterScreenState();
}

Widget buildSwitchListTile(
    String title, String subTitle, bool value, Function function) {
  return SwitchListTile(
    title: Text(title),
    subtitle: Text(subTitle),
    value: value,
    onChanged: function,
  );
}


class _FliterScreenState extends State<FliterScreen> {
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegan = false;
  bool _vegetarian = false;

  @override
  initState(){
     _glutenFree = widget.currentFilter['gluten'];
     _lactoseFree =  widget.currentFilter['lactose'];
     _vegan =  widget.currentFilter['vegan'];
     _vegetarian =  widget.currentFilter['vegetarian'];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pr,
        brightness: Brightness.dark,
        title: Text("Filters"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedFilter = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveFilter(selectedFilter);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust your meal selection",
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSwitchListTile("Gluten-free",
                    "Only include gluten free meals", _glutenFree, (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                }),
                buildSwitchListTile(
                    "Lactose-free",
                    "Only include Lactose free meals",
                    _lactoseFree, (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                  });
                }),
                buildSwitchListTile(
                    "Vegan-free", "Only include Vegan free meals", _vegan,
                    (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                }),
                buildSwitchListTile(
                    "Vegetarian-free",
                    "Only include Vegetarian free meals",
                    _vegetarian, (newValue) {
                  setState(() {
                    _vegetarian = newValue;
                  });
                }),
              ],
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
