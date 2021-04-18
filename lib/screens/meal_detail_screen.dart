import 'package:flutter/material.dart';
import 'package:my_meal/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  Function toggleFilters;
  Function isFavorite;



  MealDetailScreen(this.toggleFilters,this.isFavorite);


  static const routeName='meal_details';
  Color pr =Color(0xff131a31);
  
  Widget buildSectionTitle(BuildContext ctx ,String text){
    return  Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(text ,style: Theme.of(ctx).textTheme.title,),
    );
  }
  
  Widget buildContainer(Widget child){
    return  Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),

      height: 150,
      width: 300,
      child: child,
    );
  }
  
  
  
  
  
  
  
  @override
  Widget build(BuildContext context) {
    final mealId=ModalRoute.of(context).settings.arguments as String;
    // to filter image from all imageUrl
    final meald=DUMMY_MEALS.firstWhere((element) => element.id==mealId);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: pr,
        title: Text(meald.title),
        brightness: Brightness.dark,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(meald.imageUrl,fit: BoxFit.cover,),
              

            ),
            buildSectionTitle(context, "Ingredients"),
           
            buildContainer(ListView.builder(itemBuilder:(ctx,index){
              return Card(
                color: Theme.of(context).accentColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(meald.ingredients[index]),
                ),// mohma
              );
            } ,itemCount: meald.ingredients.length,),),
            buildSectionTitle(context, "Steps"),
            buildContainer(ListView.builder(itemBuilder:(ctx,index){
              return Column(
                children: [
              ListTile(
              leading: CircleAvatar(
              backgroundColor: pr,
                child: Text("# ${index+1}",style: TextStyle(color: Colors.white),),
              ),
              title: Text(meald.steps[index]),
              ),
                  Divider(),
                ],
              );
            } ,itemCount: meald.steps.length,),),
            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>toggleFilters(mealId),
        child: Icon(isFavorite(mealId)? Icons.star :Icons.star_border),
      ),
    );
  }
}
