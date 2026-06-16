import 'package:flutter_test/flutter_test.dart';
import 'package:forecast_app_pet_proj/core/services/network_checker/network_checker_serv.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([InternetConnectionChecker])
import 'network_checker_serv_test.mocks.dart';

void main() {
  late NetworkCheckerServ service;
  late MockInternetConnectionChecker mockChecker;

  setUp(() {
    mockChecker = MockInternetConnectionChecker();
    service = NetworkCheckerServ(serv: mockChecker);
  });

  tearDown(() {
    resetMockitoState();
  });

  group('NetworkCheckerServ', () {
    test('checking() returns true when internet available', () async {
      when(mockChecker.hasConnection).thenAnswer((_) async => true);
      final result = await service.checking();
      expect(result, true);
    });
    test('checking() returns false when no internet', () async {
      when(mockChecker.hasConnection).thenAnswer((_) async => false);
      final result = await service.checking();
      expect(result, false);
    });
    test('checking() returns false on exception', () async {
      when(mockChecker.hasConnection).thenThrow(Exception('Network error'));
      expect(() => service.checking(), throwsException);
    });
  });
}
