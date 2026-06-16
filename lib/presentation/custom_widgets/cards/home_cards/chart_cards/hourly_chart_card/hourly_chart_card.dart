import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../domain/entities/meteo_enity/meteo_enity.dart';
import '../../../../../state_management/cubit/bottom_card_change_cubit/bottom_card_change_cubit.dart';
import '../../../interface_card/opacity_card_interface.dart';
import '../chart/chart/hourly_chart/houlry_chart.dart';
import '../units/hours_units/hours_info_body.dart';

class HourlyChart extends StatelessWidget {
  final bool isMetric;
  final MeteoEntity data;

  const HourlyChart({super.key, required this.data, required this.isMetric});

  @override
  Widget build(BuildContext context) {
    final cityName = data.cityName;
    context.read<BottomCardCubit>().changeToDaily(
      cityName: data.cityName,
      index: 0,
      isMetric: isMetric,
    );
    return OpacityCardInterface(
      height: 400.0,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _TextTitleHourlyChart(),
          SizedBox(
            height: 200.0,
            child: hourlyChartBuild(
              context: context,
              data: data,
              cityName: cityName,
            ),
          ),
          HoursInfoCard(),
        ],
      ),
    );
  }
}

class _TextTitleHourlyChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final txtStyle = TextStyle(
      color: Theme.of(context).textTheme.bodyLarge?.color,
      fontSize: 18.0,
      fontWeight: FontWeight(450),
    );

    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsetsGeometry.only(left: 8.0, top: 8.0, bottom: 10.0),
        child: Text('График на ближайшие 72 часа ', style: txtStyle),
      ),
    );
  }
}
