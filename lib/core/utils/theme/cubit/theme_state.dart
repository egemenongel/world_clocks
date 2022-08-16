part of 'theme_cubit.dart';

class ThemeState {
  final bool isDark;
  ThemeData _currentTheme = AppThemeLight.instance.theme;

  ThemeData get currentTheme => _currentTheme;

  ThemeState({required this.isDark}) {
    if (isDark == true) {
      _currentTheme = AppThemeDark.instance.theme;
    } else {
      _currentTheme = AppThemeLight.instance.theme;
    }
  }

  ThemeState copyWith({bool? changeTheme}) {
    return ThemeState(isDark: changeTheme ?? isDark);
  }
}
