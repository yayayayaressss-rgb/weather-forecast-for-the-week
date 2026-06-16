import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app_pet_proj/presentation/screens/metrics_screen/metrics_screen_body/units/text_title_info.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/metric_cubit/metric_cubit.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/metric_cubit/metric_states.dart';
import '../../../custom_widgets/custom_buttons/metric_change_button/change_button.dart';

class MetricsScreenBody extends StatelessWidget {
  const MetricsScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MetricCubit, MetricState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextTitleInfo(),
            const SizedBox(height: 20.0),
            Center(child: MetricsTextButton(isMetric: state.isMetric)),
          ],
        );
      },
    );
  }
}
