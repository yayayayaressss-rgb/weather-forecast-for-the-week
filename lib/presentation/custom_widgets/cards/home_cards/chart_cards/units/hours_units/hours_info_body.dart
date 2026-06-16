import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app_pet_proj/domain/entities/meteo_enity/hourly_weather.dart';
import 'package:forecast_app_pet_proj/presentation/custom_widgets/cards/home_cards/chart_cards/units/hours_units/precipitation_probability_unit/precipitation_probability_unit.dart';
import 'package:forecast_app_pet_proj/presentation/custom_widgets/cards/home_cards/chart_cards/units/hours_units/temperature_unit_card/temperature_unit_card.dart';
import 'package:forecast_app_pet_proj/presentation/custom_widgets/cards/home_cards/chart_cards/units/hours_units/time_unit/time_unit.dart';
import '../../../../../../state_management/cubit/bottom_card_change_cubit/bottom_card_change_cubit.dart';
import '../../../../../../state_management/cubit/bottom_card_change_cubit/change_states.dart';
import '../unit_interface.dart';

class HoursInfoCard extends StatelessWidget {
  const HoursInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomCardCubit, ChangeStates>(
      buildWhen: (previous, current) {
        return current is GetChangeToHourly;
      },
      builder: (context, state) {
        switch (state) {
          case GetChangeToHourly():
            return _info(context: context, state: state);
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}

Widget _info({
  required BuildContext context,
  required GetChangeToHourly state,
}) {
  final data = state.data;
  return unitInterface(
    child: Padding(
      padding: EdgeInsetsGeometry.all(18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _firstRow(context: context, data: data),
          _secondRow(context: context, data: data),
        ],
      ),
    ),
  );
}

Widget _secondRow({
  required BuildContext context,
  required HourlyWeather data,
}) {
  return Row(
    children: [precipitationProbabilityUnit(data: data, context: context)],
  );
}

Widget _firstRow({required BuildContext context, required HourlyWeather data}) {
  return Row(
    children: [
      timeUnit(context: context, data: data),
      temperatureUnitCard(data: data, context: context),
    ],
  );
}
