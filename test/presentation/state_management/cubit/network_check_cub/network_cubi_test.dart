import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forecast_app_pet_proj/core/services/network_checker/network_checker_serv.dart';
import 'package:forecast_app_pet_proj/domain/failures/network_disconnection_failure.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/network_check_cub/network_cubit.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/network_check_cub/network_states.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_cubi_test.mocks.dart';

@GenerateMocks([NetworkCheckerServ])
void main() {
  late MockNetworkCheckerServ servMock;

  setUp(() {
    servMock = MockNetworkCheckerServ();
  });

  blocTest<NetworkCubit, NetworkState>(
    'NetworkCubit test check() foo should emit Connected when has internet',
    build: () {
      when(servMock.checking()).thenAnswer((_) async => true);
      return NetworkCubit(netWorkCheckService: servMock);
    },
    act: (cubit) => cubit.check(),
    expect: () => [const Connected()],
  );

  blocTest<NetworkCubit, NetworkState>(
    'NetworkCubit test check() foo should emit Disconnected when no internet',
    build: () {
      when(servMock.checking()).thenAnswer((_) async => false);
      return NetworkCubit(netWorkCheckService: servMock);
    },
    act: (cubit) => cubit.check(),
    expect: () => [
      const Disconnected(
        failure: NetworkDisconnectionFailure(
          message: 'Нет подлючения к интернету',
        ),
      ),
    ],
  );
}
