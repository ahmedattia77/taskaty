import 'package:dio/dio.dart';

abstract class Failure {
  final String errMessage;
  const Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with server');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with server');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout with server');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioException.response?.statusCode,
          dioException.response?.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure('Request was cancelled');
      case DioExceptionType.connectionError:
        return ServerFailure('No internet connection');
      default:
        return ServerFailure('Unexpected error occurred, please try again');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 ||
        statusCode == 401 ||
        statusCode == 403 ||
        statusCode == 422) {
      if (response is Map<String, dynamic>) {
        if (response['error'] != null &&
            response['error'].toString().isNotEmpty) {
          return ServerFailure(response['error'].toString());
        }

        if (response['data'] != null && response['data']['errors'] != null) {
          final errors = response['data']['errors'];
          if (errors is List && errors.isNotEmpty) {
            return ServerFailure(errors.first.toString());
          }
        }

        if (response['message'] != null) {
          return ServerFailure(response['message'].toString());
        }
      }
      return ServerFailure('Invalid credentials, please try again');
    } else if (statusCode == 404) {
      return ServerFailure('Request not found');
    } else if (statusCode == 500) {
      return ServerFailure('Internal server error, try later');
    } else {
      return ServerFailure('Opps, there was an error, please try again');
    }
  }
}
