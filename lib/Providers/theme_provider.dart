import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  var pr = Color(0xFF131a31);

  String themeText = "s";
  var primaryColor = MaterialColor(
    0xFF131a31,
    <int, Color>{
      50: Color(0xFFFCE4EC),
      100: Color(0xFFF8BBD0),
      200: Color(0xFFF48FB1),
      300: Color(0xFFF06292),
      400: Color(0xFFEC407A),
      500: Color(0xFF131a31),
      600: Color(0xFFD81B60),
      700: Color(0xFFC2185B),
      800: Color(0xFFAD1457),
      900: Color(0xFF880E4F),
    },
  );
  var accentColor = Colors.amber;

  var tm = ThemeMode.system;

  onChange(newColor, n) async {
    n == 1
        ? primaryColor = setMaterialColor(newColor.hashCode)
        : accentColor = setMaterialColor(newColor.hashCode);
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("primaryColor", primaryColor.value);
    prefs.setInt("accentColor", accentColor.value);
  }

  getThemeColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    primaryColor = setMaterialColor(prefs.getInt("primaryColor") ?? 0xFF131a31);
    accentColor = setMaterialColor(prefs.getInt("accentColor") ?? 0xFFFFC107);

    notifyListeners();
  }

  MaterialColor setMaterialColor(colorVal) {
    return MaterialColor(
      colorVal,
      <int, Color>{
        50: Color(0xFFFCE4EC),
        100: Color(0xFFF8BBD0),
        200: Color(0xFFF48FB1),
        300: Color(0xFFF06292),
        400: Color(0xFFEC407A),
        500: Color(colorVal),
        600: Color(0xFFD81B60),
        700: Color(0xFFC2185B),
        800: Color(0xFFAD1457),
        900: Color(0xFF880E4F),
      },
    );
  }

  void themeModeChange(newThemeVal) async {
    tm = newThemeVal;
    _getThemeText(tm);
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("themeText", themeText);
  }

  _getThemeText(ThemeMode tm) {
    if (tm == ThemeMode.system) {
      themeText = "s";
    } else if (tm == ThemeMode.light) {
      themeText = "l";
    } else if (tm == ThemeMode.dark) {
      themeText = "d";
    }
    notifyListeners();
  }

  getThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    themeText = prefs.getString("themeText") ?? "s";

    if (themeText == "s") {
      tm = ThemeMode.system;
    } else if (themeText == "l") {
      tm = ThemeMode.light;
    } else if (themeText == "d") {
      tm = ThemeMode.dark;
    }
  }
}
