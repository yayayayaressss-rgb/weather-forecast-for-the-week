import 'package:dio/dio.dart';
import '../../domain/failures/failure_interface.dart';
import '../../domain/failures/network_failures.dart';

class FailureMapper {
  static Failure fromDioError(DioException error) {
    final statusCode = error.response?.statusCode;

    if (statusCode == null) {
      return _handleNetworkErrors(error);
    }
    if (statusCode >= 400 && statusCode <= 429) {
      return _from400to429(statusCode);
    }

    if (statusCode >= 500 && statusCode <= 504) {
      return _from500to504(statusCode);
    }

    return UnknownFailure(
      message: 'Неизвестная ошибка',
      statusCode: statusCode,
    );
  }

  static Failure _handleNetworkErrors(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return NetworkFailure(
          message: 'Превышено время ожидания ответа от сервера',
          statusCode: null,
        );

      case DioExceptionType.connectionError:
        return NetworkFailure(
          message: 'Отсутствует интернет-соединение',
          statusCode: null,
        );

      case DioExceptionType.cancel:
        return NetworkFailure(message: 'Запрос был отменен', statusCode: null);

      default:
        return UnknownFailure(
          message: error.message ?? 'Неизвестная ошибка сети',
          statusCode: null,
        );
    }
  }

  static Failure _from400to429(int statusCode) {
    switch (statusCode) {
      case 400:
        return ServerFailure(
          message: 'Bad Request: Неверный формат запроса',
          statusCode: 400,
        );

      case 401:
        return AuthFailure(
          message: 'Unauthorized: API ключ недействителен',
          statusCode: 401,
        );

      case 403:
        return AuthFailure(
          message: 'Forbidden: Доступ запрещен (не тот тариф)',
          statusCode: 403,
        );

      case 404:
        return ServerFailure(
          message: 'Not Found: Город не найден',
          statusCode: 404,
        );

      case 429:
        return RateLimitFailure(
          message: 'Too Many Requests: Превышен лимит (60 запросов/мин)',
          statusCode: 429,
        );

      default:
        return UnknownFailure(
          message: 'Необработанная ошибка клиента',
          statusCode: statusCode,
        );
    }
  }

  static Failure _from500to504(int statusCode) {
    switch (statusCode) {
      case 500:
        return ServerFailure(
          message: 'Internal Server Error: Ошибка на стороне OpenWeather',
          statusCode: 500,
        );

      case 502:
        return ServerFailure(
          message: 'Bad Gateway: Проблемы с прокси/шлюзом',
          statusCode: 502,
        );

      case 503:
        return ServerFailure(
          message: 'Service Unavailable: Сервер временно не работает',
          statusCode: 503,
        );

      case 504:
        return ServerFailure(
          message: 'Gateway Timeout: Таймаут шлюза',
          statusCode: 504,
        );

      default:
        return UnknownFailure(
          message: 'Неизвестная ошибка сервера',
          statusCode: statusCode,
        );
    }
  }
}
