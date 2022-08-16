import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:world_clocks/core/extensions/context_extension.dart';
import 'package:world_clocks/features/home/cubit/home_cubit.dart';
import 'package:world_clocks/features/home/service/home_service.dart';
import 'package:world_clocks/features/timezone_detail/view/timezone_detail_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(HomeService()),
      child: Scaffold(
        appBar: AppBar(),
        body: _buildBody(),
      ),
    );
  }
}

BlocBuilder<HomeCubit, HomeState> _buildBody() {
  return BlocBuilder<HomeCubit, HomeState>(
    builder: (context, state) {
      if (state is HomeLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is HomeLoaded) {
        return RefreshIndicator(
          onRefresh: () async => context.read<HomeCubit>().fetchAreas(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: state.response
                  .map((timezone) => _buildAreaTile(context, timezone))
                  .toList(),
            ),
          ),
        );
      } else {
        return const Center(
          child: Text("ERROR"),
        );
      }
    },
  );
}

Widget _buildAreaTile(BuildContext context, String timezone) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
    child: InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => TimezoneDetailView(timezone: timezone))),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        tileColor: context.colors.primary,
        title: Text(timezone.replaceAll('/', ', ').replaceAll('_', ' ')),
        trailing: const Icon(Icons.keyboard_arrow_right_rounded),
      ),
    ),
  );
}
