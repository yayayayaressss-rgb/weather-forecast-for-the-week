import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/metric_cubit/metric_cubit.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/metric_cubit/metric_states.dart';
import 'metrics_screen_app_bar.dart';
import 'metrics_screen_body/metrics_screen_body.dart';

class MetricsScreen extends StatefulWidget {
  const MetricsScreen({super.key});

  @override
  State<StatefulWidget> createState() => MetricsScreenState();
}

class MetricsScreenState extends State<MetricsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MetricCubit, MetricState>(
      builder: (context, state) {
        return Scaffold(
          appBar: metricScreenAppBar(context: context),
          body: MetricsScreenBody(),
        );
      },
    );
  }
}
