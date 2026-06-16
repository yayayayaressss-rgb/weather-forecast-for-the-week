import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/use_cases/get_data_to_bottom_card/get_to_bottom_card_use_case.dart';
import 'change_states.dart';

class BottomCardCubit extends Cubit<ChangeStates> {
  final GetToBottomCardUseCase _useCase;

  BottomCardCubit({required GetToBottomCardUseCase useCase})
    : _useCase = useCase,
      super(EmptyChangeState());

  Future<void> changeToDaily({
    required String cityName,
    required int index,
    required bool isMetric,
  }) async {
    final result = await _useCase.getDailyWeatherItem(
      cityName: cityName,
      index: index,
      isMetric: isMetric,
    );
    result.fold(
      (l) {
        log(l.message);
        emit(FailureChangeState(data: l));
      },
      (r) {
        emit(GetChangeToDaily(data: r));
      },
    );
  }

  Future<void> changeToHourly({
    required String cityName,
    required int index,
    required bool isMetric,
  }) async {
    final result = await _useCase.getHourlyWeatherItem(
      index: index,
      cityName: cityName,
    );
    result.fold(
      (l) {
        log(l.message);
        emit(FailureChangeState(data: l));
      },
      (r) {
        emit(GetChangeToHourly(data: r));
      },
    );
  }
}
