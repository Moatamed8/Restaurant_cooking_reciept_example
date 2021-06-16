import 'package:flutter/material.dart';
import 'package:my_meal/Providers/language_provider.dart';
import 'package:my_meal/Providers/theme_provider.dart';
import 'package:my_meal/screens/fliter.dart';
import 'package:my_meal/screens/tabs_screen.dart';
import 'package:my_meal/screens/theme_screen.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
  Color pr = Color(0xff131a31);

  Widget buildListTitle(
      BuildContext context, String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
        color: Theme.of(context).textTheme.headline6.color,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline6
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Drawer(
        elevation: 0,
        child: Column(
          children: [
            Container(
              height: 170,
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: Theme.of(context).accentColor,
              alignment:
                  lan.isEn ? Alignment.centerLeft : Alignment.centerRight,
              child: Text(
                lan.getTexts('drawer_name'),
                style: TextStyle(
                    fontSize: 30, fontWeight: FontWeight.w900, color: pr),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            buildListTitle(
                context, lan.getTexts('drawer_item1'), Icons.restaurant, () {
              Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
            }),
            buildListTitle(
                context, lan.getTexts('drawer_item2'), Icons.settings, () {
              Navigator.of(context)
                  .pushReplacementNamed(FliterScreen.routeName);
            }),
            buildListTitle(
                context, lan.getTexts('drawer_item3'), Icons.color_lens, () {
              Navigator.of(context)
                  .pushReplacementNamed(ThemesScreen.routeName);
            }),
            Divider(
              height: 10,
              color: Theme.of(context).iconTheme.color,
            ),
            Container(
              alignment:Alignment.centerRight,
              padding: EdgeInsets.only(top: 20, right: 22),
              child: Text(lan.getTexts('drawer_switch_title'),
                  style: Theme.of(context).textTheme.headline6),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    lan.getTexts('drawer_switch_item1'),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Switch(
                    value: Provider.of<LanguageProvider>(context, listen: true)
                        .isEn,
                    onChanged: (newValue) {
                      Provider.of<LanguageProvider>(context, listen: false)
                          .changeLan(newValue);
                      Navigator.of(context).pop();
                    },
                    inactiveTrackColor:
                        Provider.of<ThemeProvider>(context, listen: true).tm ==
                                ThemeMode.light
                            ? Provider.of<ThemeProvider>(context, listen: false).primaryColor
                            : Provider.of<ThemeProvider>(context, listen: false).accentColor
                  ),
                  Text(lan.getTexts('drawer_switch_item2'),
                      style: Theme.of(context).textTheme.headline6),
                ],
              ),
            ),
            Divider(
              height: 10,
              color: Theme.of(context).iconTheme.color,
            ),
          ],
        ),
      ),
    );
  }
}
