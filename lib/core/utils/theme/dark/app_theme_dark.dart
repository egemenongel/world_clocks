import 'package:flutter/material.dart';

class AppThemeDark {
  static AppThemeDark? _instance;
  static AppThemeDark get instance {
    return _instance ??= AppThemeDark._init();
  }

  AppThemeDark._init();

  @override
  ThemeData get theme => ThemeData(
        colorScheme: _appColorScheme,
        canvasColor: const Color(0xff002359),
      );
  ColorScheme get _appColorScheme {
    return const ColorScheme(
      primary: Color(0xff02327D),
      onPrimary: Colors.white,
      secondary: Color(0xff02327D),
      onSecondary: Colors.white,
      background: Colors.red,
      onBackground: Colors.white,
      surface: Color(0xff02327D),
      onSurface: Color(0xff8FAFE0),
      error: Colors.red,
      onError: Colors.white,
      brightness: Brightness.dark,
    );
  }
}
