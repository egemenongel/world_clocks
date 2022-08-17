import 'package:flutter/material.dart';

class AppThemeLight {
  static AppThemeLight? _instance;
  static AppThemeLight get instance {
    return _instance ??= AppThemeLight._init();
  }

  AppThemeLight._init();

  ThemeData get theme => ThemeData(
        colorScheme: _appColorScheme,
        canvasColor: const Color(0xffFAFCFF),
        textTheme: const TextTheme(
          headline1: TextStyle(color: Color(0xff002359)),
          headline2: TextStyle(color: Color(0xff002359)),
          headline3: TextStyle(color: Color(0xff002359)),
          headline4: TextStyle(color: Color(0xff002359)),
          headline5: TextStyle(color: Color(0xff002359)),
          headline6: TextStyle(color: Color(0xff002359)),
          bodyText1: TextStyle(color: Color(0xff002359)),
          bodyText2: TextStyle(color: Color(0xff002359)),
          subtitle1: TextStyle(color: Color(0xff002359)),
          subtitle2: TextStyle(color: Color(0xff002359)),
        ),
      );
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
