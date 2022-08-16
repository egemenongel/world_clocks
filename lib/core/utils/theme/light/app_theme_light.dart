import 'package:flutter/material.dart';

class AppThemeLight {
  static AppThemeLight? _instance;
  static AppThemeLight get instance {
    return _instance ??= AppThemeLight._init();
  }

  AppThemeLight._init();

  @override
  ThemeData get theme => ThemeData(
      colorScheme: _appColorScheme, canvasColor: const Color(0xffFAFCFF));
  ColorScheme get _appColorScheme {
    return const ColorScheme(
      primary: Color(0xffE3EEFF),
      onPrimary: Color(0xff002359),
      secondary: Color(0xff8FAFE0),
      onSecondary: Colors.black,
      background: Colors.grey,
      onBackground: Color(0xff02327D),
      surface: Color(0xff8FAFE0),
      onSurface: Color(0xff02327D),
      error: Colors.red,
      onError: Colors.white,
      brightness: Brightness.light,
    );
  }
}
