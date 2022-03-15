import 'package:flutter/material.dart';
import 'package:my_meal/Providers/language_provider.dart';
import 'package:my_meal/Providers/meal_provider.dart';
import 'package:my_meal/data/dummy_data.dart';
import 'package:provider/provider.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = 'meal_details';
  Color pr = Color(0xff131a31);

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = LanguageProvider.of(context, listen: true);

    bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    //here to recieve id from meal item
    final mealId = ModalRoute.of(context).settings.arguments as String;
    // to filter image from all imageUrl // to check for the first id
    final meald = DUMMY_MEALS.firstWhere((element) => element.id == mealId);

    List<String> liStep = lan.getTexts('steps-$mealId') as List<String>;

    var liSteps = ListView.builder(
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: Text(
                  "# ${index + 1}",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              title: Text(liStep[index], style: TextStyle(color: Colors.black)),
            ),
            Divider(),
          ],
        );
      },
      itemCount: liStep.length,
    );

    List<String> ingredientLi =
        lan.getTexts('ingredients-$mealId') as List<String>;

    var ingredientsLi = ListView.builder(
      padding: EdgeInsets.all(0),

      itemBuilder: (context, index) {
        return Card(
          color: Theme.of(context).accentColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(
              ingredientLi[index],
            ),
          ), // mohma
        );
      },
      itemCount: ingredientLi.length,
    );

    Widget buildContainer(Widget child) {
      bool isLandScape =
          MediaQuery.of(context).orientation == Orientation.landscape;
      var wd = MediaQuery.of(context).size.width;
      var hd = MediaQuery.of(context).size.height;

      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        height: isLandScape ? hd * .5 : hd * .25,
        width: isLandScape ? (wd * .5 - 30) : wd,
        child: child,
      );
    }

    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(lan.getTexts('meal-$mealId')),
                background:  Hero(
                    tag: mealId,
                    child: InteractiveViewer(
                      child: FadeInImage(
                          placeholder: AssetImage('assets/images/a2.png'),
                          image: NetworkImage(
                            meald.imageUrl,
                          ),
                          fit: BoxFit.cover),
                    )),


              ),
            ),
            SliverList(delegate: SliverChildListDelegate([

              if (isLandScape)
                Row(
                  children: [
                    Column(
                      children: [
                        buildSectionTitle(context, lan.getTexts('Ingredients')),
                        buildContainer(ingredientsLi),
                      ],
                    ),
                    Column(
                      children: [
                        buildSectionTitle(context, lan.getTexts('Steps')),
                        buildContainer(liSteps),
                      ],
                    ),
                  ],
                ),
              if (!isLandScape)
                buildSectionTitle(context, lan.getTexts('Ingredients')),
              if (!isLandScape) buildContainer(ingredientsLi),
              if (!isLandScape)
                buildSectionTitle(context, lan.getTexts('Steps')),
              if (!isLandScape) buildContainer(liSteps),
            ],),),
          ],

        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => MealProvider.of(context, listen: false)
              .toggleFilters(mealId),
          child: Icon(MealProvider.of(context, listen: true)
                  .isMealFavorite(mealId)
              ? Icons.star
              : Icons.star_border),
        ),
      ),
    );
  }
}
