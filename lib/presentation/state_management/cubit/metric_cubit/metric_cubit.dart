import 'package:flutter_bloc/flutter_bloc.dart';

import 'metric_states.dart';

class MetricCubit extends Cubit<MetricState> {
  MetricCubit() : super(MetricState(isMetric: true));
  bool isMetric = true;

  Future<void> changeMetric() async {
    isMetric = !isMetric;
    emit(MetricState(isMetric: isMetric));
  }
}
