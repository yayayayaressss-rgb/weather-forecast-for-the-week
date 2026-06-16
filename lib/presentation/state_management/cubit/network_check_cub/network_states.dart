import 'package:equatable/equatable.dart';
import 'package:forecast_app_pet_proj/domain/failures/network_disconnection_failure.dart';

sealed class NetworkState extends Equatable {
  const NetworkState();
}

final class NetworkInitial extends NetworkState {
  const NetworkInitial();

  @override
  List<Object?> get props => [];
}

final class Disconnected extends NetworkState {
  final NetworkDisconnectionFailure failure;

  const Disconnected({required this.failure});

  @override
  List<Object?> get props => [failure];
}

final class Connected extends NetworkState {
  const Connected();

  @override
  List<Object?> get props => [];
}
