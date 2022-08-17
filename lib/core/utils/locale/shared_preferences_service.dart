import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static String themeKey = 'theme';
  static SharedPreferences? _preferences;
  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setTheme(bool value) async {
    await _preferences?.setBool(themeKey, value);
  }

  static getTheme() {
    return _preferences?.getBool(themeKey);
  }
}
