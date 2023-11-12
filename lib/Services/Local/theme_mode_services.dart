import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModeServices extends ChangeNotifier {
  ThemeMode _selectedTheme = ThemeMode.light;
  ThemeMode get selectedTheme => _selectedTheme;

  ThemeModeServices() {
    loadThemeMode();
  }

  void setThemeMode(ThemeMode mode) async {
    _selectedTheme = mode;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', selectedTheme.toString());
  }

  void loadThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? themeModeString = prefs.getString('theme_mode');
    if (themeModeString != null) {
      _selectedTheme = ThemeMode.values.firstWhere((e) => e.toString() == themeModeString);
      notifyListeners();
    }
  }
}
