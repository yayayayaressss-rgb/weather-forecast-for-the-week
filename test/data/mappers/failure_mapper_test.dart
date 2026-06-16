import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forecast_app_pet_proj/data/mappers/failure_mapper.dart';
import 'package:forecast_app_pet_proj/domain/failures/network_failures.dart';

void main() {
  group('FailureMapper Tests', () {
    group('Network Errors (no status code)', () {
      test('should return NetworkFailure on connectionTimeout', () {
        final error = DioException(
          type: DioExceptionType.connectionTimeout,
          requestOptions: RequestOptions(path: ''),
        );

        final result = FailureMapper.fromDioError(error);

        expect(result, isA<NetworkFailure>());
        expect(result.message, 'Превышено время ожидания ответа от сервера');
        expect(result.statusCode, isNull);
      });

      test('should return NetworkFailure on receiveTimeout', () {
        final error = DioException(
          type: DioExceptionType.receiveTimeout,
          requestOptions: RequestOptions(path: ''),
        );

        final result = FailureMapper.fromDioError(error);

        expect(result, isA<NetworkFailure>());
        expect(result.message, 'Превышено время ожидания ответа от сервера');
      });

      test('should return NetworkFailure on sendTimeout', () {
        final error = DioException(
          type: DioExceptionType.sendTimeout,
          requestOptions: RequestOptions(path: ''),
        );

        final result = FailureMapper.fromDioError(error);

        expect(result, isA<NetworkFailure>());
      });

      test('should return NetworkFailure on connectionError', () {
        final error = DioException(
          type: DioExceptionType.connectionError,
          requestOptions: RequestOptions(path: ''),
        );

        final result = FailureMapper.fromDioError(error);

        expect(result, isA<NetworkFailure>());
        expect(result.message, 'Отсутствует интернет-соединение');
      });

      test('should return NetworkFailure on cancel', () {
        final error = DioException(
          type: DioExceptionType.cancel,
          requestOptions: RequestOptions(path: ''),
        );

        final result = FailureMapper.fromDioError(error);

        expect(result, isA<NetworkFailure>());
        expect(result.message, 'Запрос был отменен');
      });

      test('should return UnknownFailure for unknown network error', () {
        final error = DioException(
          type: DioExceptionType.unknown,
          message: 'Some unknown error',
          requestOptions: RequestOptions(path: ''),
        );

        final result = FailureMapper.fromDioError(error);

        expect(result, isA<UnknownFailure>());
        expect(result.message, 'Some unknown error');
      });
    });
    group('Client Errors (400-429)', () {
      test('should return ServerFailure on 400 Bad Request', () {
        final error = DioException(
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 400,
            requestOptions: RequestOptions(path: ''),
          ),
          requestOptions: RequestOptions(path: ''),
        );

        final result = FailureMapper.fromDioError(error);

        expect(result, isA<ServerFailure>());
        expect(result.message, 'Bad Request: Неверный формат запроса');
        expect(result.statusCode, 400);
      });

      test('should return AuthFailure on 401 Unauthorized', () {
        final error = DioException(
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 401,
            requestOptions: RequestOptions(path: ''),
          ),
          requestOptions: RequestOptions(path: ''),
        );

        final result = FailureMapper.fromDioError(error);

        expect(result, isA<AuthFailure>());
        expect(result.message, 'Unauthorized: API ключ недействителен');
        expect(result.statusCode, 401);
      });

      test('should return AuthFailure on 403 Forbidden', () {
        final error = DioException(
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 403,
            requestOptions: RequestOptions(path: ''),
          ),
          requestOptions: RequestOptions(path: ''),
        );

        final result = FailureMapper.fromDioError(error);

        expect(result, isA<AuthFailure>());
        expect(result.message, 'Forbidden: Доступ запрещен (не тот тариф)');
        expect(result.statusCode, 403);
      });

      test('should return ServerFailure on 404 Not Found', () {
        final error = DioException(
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 404,
            requestOptions: RequestOptions(path: ''),
          ),
          requestOptions: RequestOptions(path: ''),
        );

        final result = FailureMapper.fromDioError(error);

        expect(result, isA<ServerFailure>());
        expect(result.message, 'Not Found: Город не найден');
        expect(result.statusCode, 404);
      });

      test('should return RateLimitFailure on 429 Too Many Requests', () {
        final error = DioException(
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 429,
            requestOptions: RequestOptions(path: ''),
          ),
          requestOptions: RequestOptions(path: ''),
        );

        final result = FailureMapper.fromDioError(error);

        expect(result, isA<RateLimitFailure>());
        expect(
          result.message,
          'Too Many Requests: Превышен лимит (60 запросов/мин)',
        );
        expect(result.statusCode, 429);
      });

      test('should return UnknownFailure for unhandled 4xx code', () {
        final error = DioException(
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 418, // I'm a teapot
            requestOptions: RequestOptions(path: ''),
          ),
          requestOptions: RequestOptions(path: ''),
        );

        final result = FailureMapper.fromDioError(error);

        expect(result, isA<UnknownFailure>());
        expect(result.message, 'Необработанная ошибка клиента');
        expect(result.statusCode, 418);
      });
    });

    group('Server Errors (500-504)', () {
      test('should return ServerFailure on 500 Internal Server Error', () {
        final error = DioException(
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 500,
            requestOptions: RequestOptions(path: ''),
          ),
          requestOptions: RequestOptions(path: ''),
        );

        final result = FailureMapper.fromDioError(error);

        expect(result, isA<ServerFailure>());
        expect(
          result.message,
          'Internal Server Error: Ошибка на стороне OpenWeather',
        );
        expect(result.statusCode, 500);
      });

      test('should return ServerFailure on 502 Bad Gateway', () {
        final error = DioException(
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 502,
            requestOptions: RequestOptions(path: ''),
          ),
          requestOptions: RequestOptions(path: ''),
        );

        final result = FailureMapper.fromDioError(error);

        expect(result, isA<ServerFailure>());
        expect(result.message, 'Bad Gateway: Проблемы с прокси/шлюзом');
        expect(result.statusCode, 502);
      });

      test('should return ServerFailure on 503 Service Unavailable', () {
        final error = DioException(
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 503,
            requestOptions: RequestOptions(path: ''),
          ),
          requestOptions: RequestOptions(path: ''),
        );

        final result = FailureMapper.fromDioError(error);

        expect(result, isA<ServerFailure>());
        expect(
          result.message,
          'Service Unavailable: Сервер временно не работает',
        );
        expect(result.statusCode, 503);
      });

      test('should return ServerFailure on 504 Gateway Timeout', () {
        final error = DioException(
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 504,
            requestOptions: RequestOptions(path: ''),
          ),
          requestOptions: RequestOptions(path: ''),
        );

        final result = FailureMapper.fromDioError(error);

        expect(result, isA<ServerFailure>());
        expect(result.message, 'Gateway Timeout: Таймаут шлюза');
        expect(result.statusCode, 504);
      });

      test('should return UnknownFailure for unhandled 5xx code', () {
        final error = DioException(
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 599,
            requestOptions: RequestOptions(path: ''),
          ),
          requestOptions: RequestOptions(path: ''),
        );

        final result = FailureMapper.fromDioError(error);

        expect(result, isA<UnknownFailure>());
        expect(result.message, 'Неизвестная ошибка');
        expect(result.statusCode, 599);
      });
    });

    group('Other status codes', () {
      test('should return UnknownFailure for status code 300', () {
        final error = DioException(
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 300,
            requestOptions: RequestOptions(path: ''),
          ),
          requestOptions: RequestOptions(path: ''),
        );

        final result = FailureMapper.fromDioError(error);

        expect(result, isA<UnknownFailure>());
        expect(result.message, 'Неизвестная ошибка');
        expect(result.statusCode, 300);
      });

      test('should return UnknownFailure for status code 100', () {
        final error = DioException(
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 100,
            requestOptions: RequestOptions(path: ''),
          ),
          requestOptions: RequestOptions(path: ''),
        );

        final result = FailureMapper.fromDioError(error);

        expect(result, isA<UnknownFailure>());
        expect(result.statusCode, 100);
      });
    });
  });
}
