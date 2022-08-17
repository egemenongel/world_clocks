import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:world_clocks/core/utils/locale/shared_preferences_service.dart';
import 'package:world_clocks/core/utils/theme/cubit/theme_cubit.dart';
import 'package:world_clocks/features/splash/view/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.init();
  runApp(BlocProvider(
    create: (context) => ThemeCubit(),
    child: BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MyApp(
          state: state,
        );
      },
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    this.state,
  }) : super(key: key);
  final ThemeState? state;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: state!.currentTheme,
        title: 'World Clocks',
        home: const SplashView());
  }
}
