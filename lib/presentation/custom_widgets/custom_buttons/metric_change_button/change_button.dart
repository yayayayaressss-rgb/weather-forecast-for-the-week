import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/metric_cubit/metric_cubit.dart';

class MetricsTextButton extends StatefulWidget {
  final bool isMetric;

  const MetricsTextButton({super.key, required this.isMetric});

  @override
  State<StatefulWidget> createState() => MetricsTextButtonState();
}

class MetricsTextButtonState extends State<MetricsTextButton> {
  @override
  Widget build(BuildContext context) {
    final isMetric = context.watch<MetricCubit>().state.isMetric;
    final txtStyle = TextStyle(
      color: Theme.of(context).textTheme.bodyLarge?.color,
      fontSize: 14.0,
      fontWeight: FontWeight(450),
    );
    return TextButton(
      onPressed: () {
        context.read<MetricCubit>().changeMetric();
      },
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _si(isMetric: isMetric, context: context, txtStyle: txtStyle),
            _us(isMetric: isMetric, context: context, txtStyle: txtStyle),
          ],
        ),
      ),
    );
  }
}

Widget _si({
  required bool isMetric,
  required BuildContext context,
  required TextStyle txtStyle,
}) {
  final decor = BoxDecoration(
    borderRadius: BorderRadiusGeometry.circular(16.0),
    color: isMetric ? Theme.of(context).iconTheme.color : Colors.blueGrey,
  );
  return Container(
    decoration: decor,
    child: Center(
      child: Padding(
        padding: EdgeInsetsGeometry.all(12.0),
        child: Text('Метрическая система', style: txtStyle),
      ),
    ),
  );
}

Widget _us({
  required bool isMetric,
  required BuildContext context,
  required TextStyle txtStyle,
}) {
  final decor = BoxDecoration(
    borderRadius: BorderRadiusGeometry.circular(16.0),
    color: isMetric ? Colors.blueGrey : Theme.of(context).iconTheme.color,
  );
  return Container(
    decoration: decor,
    child: Center(
      child: Padding(
        padding: EdgeInsetsGeometry.all(12.0),
        child: Text('Имперская система', style: txtStyle),
      ),
    ),
  );
}
