import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:world_clocks/core/utils/locale/shared_preferences_service.dart';
import 'package:world_clocks/core/utils/theme/dark/app_theme_dark.dart';
import 'package:world_clocks/core/utils/theme/light/app_theme_light.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(isDark: false));
  bool isDark = false;
  void toggleSwitch() {
    isDark = !isDark;
    emit(state.copyWith(changeTheme: isDark));
  }

  void changeTheme(bool value) {
    emit(state.copyWith(changeTheme: value));
  }

  void changeThemeWithLocale() {
    bool value = SharedPreferencesService.getTheme();
    value != null ? emit(state.copyWith(changeTheme: value)) : null;
  }
}
