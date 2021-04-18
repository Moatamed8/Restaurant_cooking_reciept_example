import 'package:flutter/material.dart';
import 'package:my_meal/screens/fliter.dart';
class MainDrawer extends StatelessWidget {
  Color pr =Color(0xff131a31);

  Widget buildListTitle(String title,IconData icon,Function tapHandler){
    return ListTile(
      leading: Icon(icon,size: 26,),
      title: Text(title,style: TextStyle(
        fontSize: 24,
        fontFamily: 'RobotoCondensed',
        fontWeight: FontWeight.w700,

      ),),
      onTap: tapHandler,
    );

  }





  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Theme.of(context).accentColor,
            alignment: Alignment.centerLeft,
            child: Text('Cooking Up !',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w900,color:pr ),),
          ),
          SizedBox(height: 20,),
          buildListTitle("Meal", Icons.restaurant,(){
            Navigator.of(context).pushReplacementNamed('/');
          }),
          buildListTitle("Filter", Icons.settings,(){
            Navigator.of(context).pushReplacementNamed(FliterScreen.routeName);

          }),


        ],
      ),
    );
  }
}
