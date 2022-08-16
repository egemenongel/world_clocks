import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:world_clocks/features/home/cubit/home_cubit.dart';
import 'package:world_clocks/features/home/service/home_service.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(HomeService()),
      child: Scaffold(
        appBar: AppBar(),
        body: Container(),
      ),
    );
  }
}
