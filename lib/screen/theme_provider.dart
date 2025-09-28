import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDark = false;

  bool get isDark => _isDark;

  ThemeData get themeData => _isDark
      ? ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.grey,
          scaffoldBackgroundColor: const Color.fromARGB(221, 0, 0, 0),
        )
      : ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.grey,
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
        );

  ThemeProvider() {
    _loadTheme(); 
  }
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDark = prefs.getBool('isDark') ?? false;
    notifyListeners();
  }
  Future<void> toggleTheme() async {
    _isDark = !_isDark;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', _isDark);
  }
  Future<void> clearTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isDark');
    _isDark = false; 
    notifyListeners();
  }
}