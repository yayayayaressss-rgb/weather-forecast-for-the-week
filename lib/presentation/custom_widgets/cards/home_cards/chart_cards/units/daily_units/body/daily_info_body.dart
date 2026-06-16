import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app_pet_proj/domain/entities/meteo_enity/daily_weather.dart';
import '../../../../../../../state_management/cubit/bottom_card_change_cubit/bottom_card_change_cubit.dart';
import '../../../../../../../state_management/cubit/bottom_card_change_cubit/change_states.dart';
import '../../unit_interface.dart';
import '../date_unit.dart';
import '../max_min_temp_unit.dart';
import '../sunrise_sunset_unit.dart';
import '../weather_icon.dart';

class DailyInfoCard extends StatelessWidget {
  final String cityName;

  const DailyInfoCard({required this.cityName, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomCardCubit, ChangeStates>(
      buildWhen: (previous, current) {
        return current is GetChangeToDaily;
      },
      builder: (context, state) {
        switch (state) {
          case GetChangeToDaily():
            return IntoDaily(state: state, cityName: cityName);
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}

class IntoDaily extends StatelessWidget {
  final GetChangeToDaily state;
  final String cityName;

  const IntoDaily({required this.cityName, super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final data = state.data;
    return unitInterface(
      child: Padding(
        padding: EdgeInsetsGeometry.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CityName(cityName: cityName),
            FirstDailyInfoRow(data: data, cityName: cityName),
            SecondDailyInfoRow(data: data),
            ThirdDailyInfoRow(data: data),
          ],
        ),
      ),
    );
  }
}

class CityName extends StatelessWidget {
  final String cityName;

  const CityName({super.key, required this.cityName});

  @override
  Widget build(BuildContext context) {
    TextStyle txtStyle = TextStyle(
      fontSize: 15.0,
      fontWeight: FontWeight(350),
      color: Theme.of(context).textTheme.bodyLarge?.color,
    );
    return Text(cityName, style: txtStyle);
  }
}

class FirstDailyInfoRow extends StatelessWidget {
  final String cityName;
  final DailyWeather data;

  const FirstDailyInfoRow({
    super.key,
    required this.cityName,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        dateUnit(context: context, data: data, cityName: cityName),
        weatherIconDaile(data: data),
      ],
    );
  }
}

class SecondDailyInfoRow extends StatelessWidget {
  final DailyWeather data;

  const SecondDailyInfoRow({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [minMaxTempUnit(context: context, data: data)],
    );
  }
}

class ThirdDailyInfoRow extends StatelessWidget {
  final DailyWeather data;

  const ThirdDailyInfoRow({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [sunRiseSunSetUnit(context: context, data: data)],
    );
  }
}
