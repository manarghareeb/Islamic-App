import 'package:dio/dio.dart';
import 'package:islamic_app/core/api/api_consumer.dart';
import 'package:islamic_app/core/api/api_interceptors.dart';
import 'package:islamic_app/core/error/expections.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    //dio.options.baseUrl = EndPoint.baseUrl;
    dio.options = BaseOptions(
      //baseUrl: EndPoint.baseUrl,
      baseUrl: '',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 10),
      followRedirects: true,
      validateStatus: (status) {
        return status != null && status < 500;
      },
    );
    dio.interceptors.add(ApiInterceptor());
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    );
    dio.options.validateStatus = (status) {
      return status != null && status < 500;
    };
    // edit
    dio.options.followRedirects = true;
  }

  @override
  Future delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  // @override
  // Future patch(
  //   String path, {
  //   dynamic data,
  //   Map<String, dynamic>? queryParameters,
  //   bool isFromData = false,
  // }) async {
  //   try {
  //     final response = await dio.patch(
  //       path,
  //       data: isFromData ? FormData.fromMap(data) : data,
  //       queryParameters: queryParameters,
  //     );
  //     return response.data;
  //   } on DioException catch (e) {
  //     handleDioExceptions(e);
  //   }
  // }

  @override
  Future patch(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        bool isFromData = false,
      }) async {
    try {
      final response = await dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            "Content-Type": isFromData ? "multipart/form-data" : "application/json",
          },
        ),
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }


  @override
  Future post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }
}
