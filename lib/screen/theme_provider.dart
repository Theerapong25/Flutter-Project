import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDark = false;

  bool get isDark => _isDark;

  ThemeData get themeData => _isDark
      ? ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.grey,
          scaffoldBackgroundColor: const Color.fromARGB(221, 242, 206, 206),
        )
      : ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.grey,
          scaffoldBackgroundColor: Colors.grey[200], 
        );
  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}