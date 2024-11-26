import 'package:flutter/material.dart';
import 'package:twitter_clone/themes/darkmode.dart';
import 'package:twitter_clone/themes/lightmode.dart';

class Themeprovider  with ChangeNotifier{
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData ==darkMode;

  set themeData (ThemeData themeData) {
    _themeData = themeData;

    notifyListeners();
  }


  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}