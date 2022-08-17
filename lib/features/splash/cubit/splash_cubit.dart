import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:world_clocks/core/utils/locale/shared_preferences_service.dart';
import 'package:world_clocks/core/utils/theme/cubit/theme_cubit.dart';
import 'package:world_clocks/features/home/view/home_view.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashInitial());

  void navigateToHome(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2)).then((value) {
      if (SharedPreferencesService.getTheme() == null) {
        SharedPreferencesService.setTheme(false);
      } else {
         if (SharedPreferencesService.getTheme() != false) {
          context.read<ThemeCubit>().toggleSwitch();
        }
      }
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const HomeView()));
    });
  }
}
