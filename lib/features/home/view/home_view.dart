import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:world_clocks/core/components/circular_icon_button.dart';
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
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Stack(
            children: [
              Scaffold(
                appBar: _buildAppBar(context),
                body: RefreshIndicator(
                    onRefresh: () async =>
                        context.read<HomeCubit>().fetchAreas(),
                    child: _buildBody(context, state)),
              ),
            ],
          );
        },
      ),
    );
  }
}

AppBar _buildAppBar(BuildContext context) {
  return AppBar(
    titleSpacing: 20,
    backgroundColor: context.colors.primary,
    foregroundColor: context.colors.onPrimary,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32))),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Günaydın, Özgür!'),
        const SizedBox(
          height: 10,
        ),
        FittedBox(
          child: Text(
            DateFormat(DateFormat.HOUR24_MINUTE).format(DateTime.now()),
            style: const TextStyle(fontSize: 30),
          ),
        ),
        const SizedBox(
          height: 10,
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
          return CircularIconButton(
            iconData: state.isDark
                ? Icons.light_mode_outlined
                : Icons.dark_mode_outlined,
            voidCallback: () => context.read<ThemeCubit>().toggleSwitch(),
            backgroundColor: context.colors.onPrimary,
            iconColor: context.colors.primary,
          );
        },
      ),
    ],
    toolbarHeight: kToolbarHeight * 3.5,
    elevation: 0,
    automaticallyImplyLeading: false,
  );
}

Widget _buildBody(BuildContext context, HomeState state) {
  if (state is HomeLoading || state is HomeInital) {
    return const Center(child: CircularProgressIndicator());
  } else if (state is HomeLoaded) {
    return SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: state.response
                .map((timezone) => _buildAreaTile(context, timezone))
                .toList()));
  } else {
    return const Center(
      child: Text("ERROR"),
    );
  }
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
        title: Text(timezone.replaceAll('/', ', ').replaceAll('_', ' '),
            style: context.textTheme.subtitle1!
                .copyWith(color: context.colors.onPrimary)),
        trailing: const Icon(Icons.keyboard_arrow_right_rounded),
      ),
    ),
  );
}
