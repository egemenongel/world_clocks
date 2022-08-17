import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:world_clocks/features/home/view/home_view.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashInitial());

  void navigateToHome(BuildContext context) {
    Future.delayed(const Duration(seconds: 2)).then((value) =>
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const HomeView())));
  }
}
