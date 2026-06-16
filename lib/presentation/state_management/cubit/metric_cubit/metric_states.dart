import 'package:equatable/equatable.dart';

class MetricState extends Equatable {
  final bool isMetric;

  const MetricState({required this.isMetric});

  @override
  List<Object?> get props => [isMetric];
}
