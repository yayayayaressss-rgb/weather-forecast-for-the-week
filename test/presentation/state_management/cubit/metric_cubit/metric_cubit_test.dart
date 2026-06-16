import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/metric_cubit/metric_cubit.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/metric_cubit/metric_states.dart';

void main() {
  test('MetricCubit init state test', () {
    final MetricCubit cubit = MetricCubit();
    expect(cubit.state.isMetric, true);
    cubit.close();
  });

  blocTest<MetricCubit, MetricState>(
    'emits [MetricState(isMetric: false)] when changeMetric() is called',
    build: () => MetricCubit(),
    act: (cubit) => cubit.changeMetric(),
    expect: () => [MetricState(isMetric: false)],
  );
}
