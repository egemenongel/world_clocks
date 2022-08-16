import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:world_clocks/core/extensions/context_extension.dart';
import 'package:world_clocks/core/utils/theme/cubit/theme_cubit.dart';
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
        appBar: _buildAppBar(context),
        body: _buildBody(),
      ),
    );
  }
}

AppBar _buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: context.colors.secondary,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32))),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Günaydın, Özgür!'),
        FittedBox(
          child: Text(
            DateFormat(DateFormat.HOUR24_MINUTE).format(DateTime.now()),
            style: const TextStyle(fontSize: 30),
          ),
        ),
        FittedBox(
          child: Text(
            DateFormat.MMMMEEEEd()
                .format(DateTime.now())
                .split(',')
                .reversed
                .join(', '),
          ),
        ),
      ],
    ),
    actions: [
      BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return IconButton(
              onPressed: () {
                context.read<ThemeCubit>().toggleSwitch(!state.isDark);
              },
              icon: const Icon(Icons.dark_mode_outlined));
        },
      )
    ],
    toolbarHeight: kToolbarHeight * 3,
    elevation: 0,
  );
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
