import 'package:flutter/material.dart';
import 'package:my_meal/Providers/language_provider.dart';
import 'package:my_meal/screens/meal_detail_screen.dart';
import 'package:provider/provider.dart';
import '../models/meal.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  const MealItem(this.id, this.imageUrl, this.duration, this.complexity,
      this.affordability);

  void selectMeal(BuildContext ctx) {
    Navigator.of(ctx)
        .pushNamed(MealDetailScreen.routeName, arguments: id)
        .then((value) {
      //  if(value != null)removeItem(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);

    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            Stack(
              //using stack for put all widget in another
              children: [
                ClipRRect(
                  //ClipRRect using this to crop image edge
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  child: Hero(
                      tag: id,
                      child: InteractiveViewer(
                        child: FadeInImage(
                            height: 200,
                            width: double.infinity,
                            placeholder: AssetImage('assets/images/a2.png'),
                            image: NetworkImage(
                              imageUrl,
                            ),
                            fit: BoxFit.cover),
                      )),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    alignment:
                    lan.isEn ? Alignment.centerLeft : Alignment.centerRight,
                    width: 300,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      lan.getTexts('meal-$id'),
                      style: TextStyle(fontSize: 26, color: Colors.white),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(Icons.schedule),
                      Text(
                        "$duration min",
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.work),
                      Text(
                        lan.getTexts('$complexity'),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.attach_money),
                      Text(
                        lan.getTexts('$affordability'),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
