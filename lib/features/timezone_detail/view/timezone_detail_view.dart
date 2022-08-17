import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:world_clocks/core/extensions/context_extension.dart';
import 'package:world_clocks/features/timezone_detail/cubit/timezone_detail_cubit.dart';
import 'package:world_clocks/features/timezone_detail/model/timezone_model.dart';
import 'package:world_clocks/features/timezone_detail/service/timezone_service.dart';

class TimezoneDetailView extends StatelessWidget {
  const TimezoneDetailView({
    Key? key,
    required this.timezone,
  }) : super(key: key);
  final String timezone;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimezoneDetailCubit(TimezoneService()),
      child: Scaffold(
          appBar: _buildAppBar(context),
          body: BlocBuilder<TimezoneDetailCubit, TimezoneDetailState>(
            builder: (context, state) {
              if (state is TimezoneDetailLoading ||
                  state is TimezoneDetailInital) {
                context.read<TimezoneDetailCubit>().fetchTimezone(timezone);
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TimezoneDetailLoaded) {
                return _buildBody(context, state.response);
              } else {
                context.read<TimezoneDetailCubit>().fetchTimezone(timezone);
                return const Center(
                  child: Text("ERROR"),
                );
              }
            },
          )),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        "WORLD TIME",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      foregroundColor: context.colors.onPrimary,
      centerTitle: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32))),
      elevation: 0,
    );
  }

  Widget _buildBody(BuildContext context, TimezoneModel timezoneModel) {
    final String clock = timezoneModel.datetime.toString().split('T')[1];
    final List<String> countryArray = timezoneModel.timezone!.split('/');
    return Padding(
      padding: context.paddingNormal,
      child: Column(
        children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 5,
                child: _buildClockTile(context, clock.substring(0, 2)),
              ),
              Expanded(
                flex: 1,
                child: _buildDots(context),
              ),
              Expanded(
                flex: 5,
                child: _buildClockTile(context, clock.substring(3, 5)),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          _buildArea(context, countryArray),
          const SizedBox(
            height: 10,
          ),
          _buildCountry(context, countryArray),
          const SizedBox(
            height: 10,
          ),
          _buildDate(context, timezoneModel),
        ],
      ),
    );
  }

  Container _buildClockTile(
    BuildContext context,
    String timePart,
  ) {
    return Container(
      padding: context.paddingNormal,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: context.colors.onSurface),
      ),
      child: FittedBox(
          child: Text(
        timePart,
        style: TextStyle(color: context.colors.onPrimary),
      )),
    );
  }

  Column _buildDots(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.colors.onPrimary,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.colors.onPrimary,
          ),
        ),
      ],
    );
  }

  Text _buildArea(BuildContext context, List<String> countryArray) {
    return Text(
      countryArray.length == 3
          ? '${countryArray[1].split('_').join(' ')}, ${countryArray[2].split('_').join(' ')}'
          : countryArray[1].split('_').join(' '),
      style: context.textTheme.headline6!.copyWith(),
    );
  }

  Text _buildCountry(BuildContext context, List<String> countryArray) =>
      Text(countryArray[0], style: context.textTheme.bodyText2!.copyWith());

  Column _buildDate(BuildContext context, TimezoneModel timezoneModel) {
    final DateTime date = DateTime.parse(timezoneModel.datetime!.split('T')[0]);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat('EEEE').format(date),
            ),
            const Text(', GMT'),
            Text(' ${timezoneModel.utcOffset}'),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(DateFormat('MMMM').format(date)),
            Text(' ${date.day}, '),
            Text('${date.year}'),
          ],
        ),
      ],
    );
  }
}
