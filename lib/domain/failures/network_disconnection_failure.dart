import 'package:forecast_app_pet_proj/domain/failures/failure_interface.dart';

class NetworkDisconnectionFailure extends Failure {
  const NetworkDisconnectionFailure({required super.message});

  @override
  List<Object?> get props => [message];
}
