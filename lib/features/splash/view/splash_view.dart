import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:world_clocks/core/constants/asset_paths.dart';
import 'package:world_clocks/features/splash/cubit/splash_cubit.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..navigateToHome(context),
      child: BlocBuilder<SplashCubit, SplashState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xff002359),
            body: Center(
              child: Image.asset(AssetPaths.logo),
            ),
          );
        },
      ),
    );
  }
}
