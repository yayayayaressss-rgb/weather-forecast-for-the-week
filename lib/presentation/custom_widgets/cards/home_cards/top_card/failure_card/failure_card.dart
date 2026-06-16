import 'package:flutter/material.dart';
import 'package:forecast_app_pet_proj/domain/failures/failure_interface.dart';
import '../../../../../../domain/failures/network_disconnection_failure.dart';
import '../../../../../../domain/failures/parsing_failure.dart';
import 'body.dart';

class FailureCard extends StatelessWidget {
  final Failure failure;

  const FailureCard({super.key, required this.failure});

  @override
  Widget build(BuildContext context) {
    final textS = TextStyle(
      fontSize: 19.0,
      color: Theme.of(context).colorScheme.error,
      fontWeight: FontWeight(700),
    );

    if (failure is ParsingFailure) {
      return bodyFailureCard(child: Text(failure.message, style: textS));
    }
    if (failure is NetworkDisconnectionFailure) {
      return bodyFailureCard(child: Text(failure.message, style: textS));
    }
    if (failure.message.isNotEmpty) {
      return bodyFailureCard(
        child: Center(child: Text(failure.message, style: textS)),
      );
    }
    return SizedBox(
      width: double.maxFinite,
      height: 100.0,
      child: bodyFailureCard(
        child: Center(child: Text('Неизвестная ошибка', style: textS)),
      ),
    );
  }
}
