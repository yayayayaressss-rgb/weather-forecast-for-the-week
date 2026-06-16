import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/network_checker/network_checker_serv.dart';
import '../../../../domain/failures/network_disconnection_failure.dart';
import 'network_states.dart';

class NetworkCubit extends Cubit<NetworkState> {
  final NetworkCheckerServ _netWorkCheckService;

  NetworkCubit({required NetworkCheckerServ netWorkCheckService})
      : _netWorkCheckService = netWorkCheckService,
        super(const NetworkInitial());

  Future<void> check() async {
    final connection = await _netWorkCheckService.checking();
    if (!isClosed) {
      emit(
        connection
            ? const Connected()
            : const Disconnected(
          failure: NetworkDisconnectionFailure(
            message: 'Нет подлючения к интернету',
          ),
        ),
      );
    }
  }
}
