import 'package:dio/dio.dart';
import 'package:islamic_app/core/error/error_model.dart';
import 'package:islamic_app/core/error/failures.dart';

class ServerException implements Exception {
  final ErrorModel errModel;

  ServerException({required this.errModel});
  ServerFailure toFailure() => ServerFailure(errModel.errorMessage);
}

void handleDioExceptions(DioException e) {
  if (e.response != null) {
    throw ServerException(
      errModel: ErrorModel.fromJson(e.response!.data is Map 
        ? e.response!.data 
        : {'errorMessage': "Server Error", 'status': e.response!.statusCode}),
    );
  }

  String message;
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ServerException(errModel: ErrorModel(errorMessage: "Connection timeout"));
    case DioExceptionType.sendTimeout:
      throw ServerException(errModel: ErrorModel(errorMessage: "Send timeout"));
    case DioExceptionType.receiveTimeout:
      throw ServerException(errModel: ErrorModel(errorMessage: "Receive timeout"));
    case DioExceptionType.badCertificate:
      throw ServerException(errModel: ErrorModel(errorMessage: "Invalid SSL certificate"));
    case DioExceptionType.cancel:
      throw ServerException(errModel: ErrorModel(errorMessage: "Request cancelled"));
    case DioExceptionType.connectionError:
      throw ServerException(errModel: ErrorModel(errorMessage: "No internet connection"));
    case DioExceptionType.unknown:
      throw ServerException(errModel: ErrorModel(errorMessage: "Unexpected error occurred"));
    //case DioExceptionType.badResponse:
      //throw ServerException(errModel: ErrorModel(errorMessage: message, status: 500));
    default: message = "Unexpected error occurred";
  }
  throw ServerException(errModel: ErrorModel(errorMessage: message, status: 500));
  
}
/*void handleDioExceptions(DioException e) {
  final res = e.response;
  final statusCode = res?.statusCode ?? 0;
  final data = res?.data;

  Map<String, dynamic>? parsedData;

  if (data is Map<String, dynamic>) {
    parsedData = data;
  } else if (data is String && data.isNotEmpty) {
    try {
      parsedData = jsonDecode(data) as Map<String, dynamic>;
    } catch (_) {
      parsedData = null;
    }
  }

  final errorMessage = parsedData?['message'] ??
      parsedData?['errorMessage'] ??
      parsedData?['error'] ??
      "Something went wrong";

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ServerException(errModel: ErrorModel(errorMessage: "Connection timeout"));
    case DioExceptionType.sendTimeout:
      throw ServerException(errModel: ErrorModel(errorMessage: "Send timeout"));
    case DioExceptionType.receiveTimeout:
      throw ServerException(errModel: ErrorModel(errorMessage: "Receive timeout"));
    case DioExceptionType.badCertificate:
      throw ServerException(errModel: ErrorModel(errorMessage: "Invalid SSL certificate"));
    case DioExceptionType.cancel:
      throw ServerException(errModel: ErrorModel(errorMessage: "Request cancelled"));
    case DioExceptionType.connectionError:
      throw ServerException(errModel: ErrorModel(errorMessage: "No internet connection"));
    case DioExceptionType.unknown:
      throw ServerException(errModel: ErrorModel(errorMessage: "Unexpected error occurred"));
    case DioExceptionType.badResponse:
      throw ServerException(
        errModel: ErrorModel(
          status: statusCode,
          errorMessage: errorMessage,
        ),
      );
  }
}*/
