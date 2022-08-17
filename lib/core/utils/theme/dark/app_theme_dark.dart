import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeDark {
  static AppThemeDark? _instance;
  static AppThemeDark get instance {
    return _instance ??= AppThemeDark._init();
  }

  AppThemeDark._init();

  ThemeData get theme => ThemeData(
        colorScheme: _appColorScheme,
        canvasColor: const Color(0xff002359),
        textTheme: GoogleFonts.montserratTextTheme(
          const TextTheme(
            headline1: TextStyle(color: Colors.white),
            headline2: TextStyle(color: Colors.white),
            headline3: TextStyle(color: Colors.white),
            headline4: TextStyle(color: Colors.white),
            headline5: TextStyle(color: Colors.white),
            headline6: TextStyle(color: Colors.white),
            bodyText1: TextStyle(color: Colors.white),
            bodyText2: TextStyle(color: Colors.white),
            subtitle1: TextStyle(color: Colors.white),
            subtitle2: TextStyle(color: Colors.white),
          ),
        ),
      );
  ColorScheme get _appColorScheme {
    return const ColorScheme(
      primary: Color(0xff02327D),
      onPrimary: Colors.white,
      secondary: Color(0xff02327D),
      onSecondary: Colors.white,
      background: Color(0xff002359),
      onBackground: Colors.white,
      surface: Color(0xff02327D),
      onSurface: Color(0xff02327D),
      error: Colors.red,
      onError: Colors.white,
      brightness: Brightness.dark,
    );
  }
}
