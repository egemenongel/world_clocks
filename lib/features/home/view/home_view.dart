import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:world_clocks/core/components/circular_icon_button.dart';
import 'package:world_clocks/core/extensions/context_extension.dart';
import 'package:world_clocks/core/utils/locale/shared_preferences_service.dart';
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
          return Scaffold(
            body: Stack(
              clipBehavior: Clip.antiAlias,
              children: [
                Positioned(
                  top: 0,
                  height: kToolbarHeight * 5,
                  width: context.width,
                  child: _buildAppBar(context),
                ),
                Positioned(
                  top: 240,
                  left: 0.0,
                  right: 0.0,
                  child: _buildSearchBar(context),
                ),
                Positioned.fill(
                  top: 300,
                  child: RefreshIndicator(
                      onRefresh: () async =>
                          context.read<HomeCubit>().fetchAreas(),
                      child: _buildBody(context, state)),
                ),
              ],
            ),
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
        const Text('G??nayd??n, ??zg??r!'),
        const SizedBox(
          height: 10,
        ),
        Text(
          DateFormat(DateFormat.HOUR24_MINUTE).format(DateTime.now()),
          style: context.textTheme.headline4!
              .copyWith(fontWeight: FontWeight.bold),
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
            voidCallback: () {
              context.read<ThemeCubit>().toggleSwitch();
              SharedPreferencesService.setTheme(
                  context.read<ThemeCubit>().isDark);
            },
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

Widget _buildSearchBar(BuildContext context) {
  return Padding(
    padding: context.paddingNormalHorizontal,
    child: TextField(
        style: context.textTheme.bodyText1!
            .copyWith(color: const Color(0xff002359)),
        decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.search,
              color: Color(0xff002359),
            ),
            hintText: 'Arama',
            hintStyle: const TextStyle(color: Color(0xff002359)),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ))),
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
            children: [
          const SizedBox(
            height: 10,
          ),
          ...state.response
              .map((timezone) => _buildAreaTile(context, timezone))
              .toList()
        ]));
  } else {
    return const Center(
      child: Text("ERROR"),
    );
  }
}

SizedBox _buildAreaTile(BuildContext context, String timezone) {
  return SizedBox(
    height: 70,
    child: Stack(
      children: [
        _buildTitle(context, timezone),
        _buildArrowIcon(context, timezone),
      ],
    ),
  );
}

Padding _buildTitle(BuildContext context, String timezone) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: Column(
      children: [
        InkWell(
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                height: 60,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: context.colors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text(timezone.replaceAll('/', ', ').replaceAll('_', ' '),
                        style: context.textTheme.subtitle1!
                            .copyWith(color: context.colors.onPrimary)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Container _buildArrowIcon(BuildContext context, String timezone) {
  return Container(
    padding: const EdgeInsets.only(right: 5),
    height: 60,
    child: Align(
      alignment: Alignment.centerRight,
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TimezoneDetailView(timezone: timezone))),
        icon: CircleAvatar(
          backgroundColor: context.colors.background,
          radius: 15,
          child: CircleAvatar(
            backgroundColor: context.colors.primary,
            radius: 12,
            child: Icon(
              Icons.keyboard_arrow_right,
              color: context.colors.onPrimary,
            ),
          ),
        ),
      ),
    ),
  );
}
