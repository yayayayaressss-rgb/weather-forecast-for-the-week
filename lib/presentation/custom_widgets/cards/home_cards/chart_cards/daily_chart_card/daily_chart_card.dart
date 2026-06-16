import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../domain/entities/meteo_enity/meteo_enity.dart';
import '../../../../../state_management/cubit/bottom_card_change_cubit/bottom_card_change_cubit.dart';
import '../../../interface_card/opacity_card_interface.dart';
import '../chart/chart/daily_chart/daily_chart.dart';
import '../units/daily_units/body/daily_info_body.dart';

class DailyChart extends StatelessWidget {
  final bool isMetric;
  final MeteoEntity data;

  const DailyChart({super.key, required this.data, required this.isMetric});

  @override
  Widget build(BuildContext context) {
    final txtStyle = TextStyle(
      color: Theme.of(context).textTheme.bodyLarge?.color,
      fontSize: 18.0,
      fontWeight: FontWeight(450),
    );
    context.read<BottomCardCubit>().changeToHourly(
      index: 0,
      cityName: data.cityName,
      isMetric: isMetric,
    );
    return OpacityCardInterface(
      height: 445.0,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsetsGeometry.only(
                left: 8.0,
                top: 8.0,
                bottom: 10.0,
              ),
              child: Text('График на ближайшие 7 дней ', style: txtStyle),
            ),
          ),
          SizedBox(
            height: 200.0,
            child: DailyChartBuild(data: data),
          ),
          DailyInfoCard(cityName: data.cityName),
        ],
      ),
    );
  }
}
