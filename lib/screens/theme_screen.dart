import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:my_meal/Providers/language_provider.dart';
import 'package:my_meal/widget/main_drawer.dart';
import 'package:provider/provider.dart';
import 'package:my_meal/Providers/theme_provider.dart';
import 'package:flutter/material.dart';

class ThemesScreen extends StatelessWidget {
  static const routeName = "/themes";

  final bool fromOnBoarding;

  ThemesScreen({this.fromOnBoarding = false});

  Widget buildSwitchListTile(
      String title, String description, bool currentVal, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentVal,
      subtitle: Text(description),
      onChanged: updateValue,
      inactiveTrackColor: Colors.black,
    );
  }

  Widget buildRadioListTile(
      ThemeMode themeVal, String txt, IconData icon, BuildContext ctx) {
    return RadioListTile(
      secondary: Icon(
        icon,
        color: Theme.of(ctx).buttonColor,
      ),
      value: themeVal,
      groupValue: ThemeProvider.of(ctx, listen: true).tm,
      onChanged: (newThemeVal) => ThemeProvider.of(ctx, listen: false)
          .themeModeChange(newThemeVal),
      title: Text(txt),
    );
  }

  Widget build(BuildContext context) {
    var lan = LanguageProvider.of(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: fromOnBoarding
            ? AppBar(elevation: 0,
                backgroundColor: Theme.of(context).canvasColor,
              )
            : AppBar(
                brightness: Brightness.dark,
                title: Text(lan.getTexts("theme_appBar_title")),
              ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                lan.getTexts("theme_screen_title"),
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      lan.getTexts("theme_mode_title"),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  buildRadioListTile(
                      ThemeMode.system,
                      lan.getTexts("System_default_theme"),
                      Icons.settings,
                      context),
                  buildRadioListTile(
                      ThemeMode.light,
                      lan.getTexts("light_theme"),
                      Icons.wb_sunny_outlined,
                      context),
                  buildRadioListTile(ThemeMode.dark, lan.getTexts("dark_theme"),
                      Icons.nights_stay_outlined, context),
                  buildListTile(context, lan.getTexts("primary")),
                  buildListTile(context, lan.getTexts("accent")),
                  SizedBox(height: fromOnBoarding? 80:0,)
                ],
              ),
            ),
          ],
        ),
        drawer: fromOnBoarding ? null : MainDrawer(),
      ),
    );
  }

  ListTile buildListTile(BuildContext context, String txt) {
    var primaryColor = Provider.of<ThemeProvider>(context).primaryColor;
    var accentColor = Provider.of<ThemeProvider>(context).accentColor;
    var lan = Provider.of<LanguageProvider>(context, listen: true);

    return ListTile(
      title: Text(
        txt,
        style: Theme.of(context).textTheme.headline6,
      ),
      trailing: CircleAvatar(
        backgroundColor:
            txt == lan.getTexts("primary") ? primaryColor : accentColor,
      ),
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext ctx) {
              return AlertDialog(
                elevation: 4,
                titlePadding: const EdgeInsets.all(0.0),
                contentPadding: const EdgeInsets.all(0.0),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: txt == lan.getTexts("primary")
                        ? Provider.of<ThemeProvider>(context, listen: true)
                            .primaryColor
                        : Provider.of<ThemeProvider>(context, listen: true)
                            .accentColor,
                    onColorChanged: (newColor) =>
                        Provider.of<ThemeProvider>(context, listen: false)
                            .onChange(newColor, txt ==lan.getTexts("primary") ? 1 : 2),
                    colorPickerWidth: 300,
                    pickerAreaHeightPercent: 0.7,
                    enableAlpha: false,
                    displayThumbColor: false,
                    showLabel: false,
                  ),
                ),
              );
            });
      },
    );
  }
}
