// import 'package:dio/dio.dart';
// import 'package:homesta/core/api/api_keys.dart';
// import 'package:homesta/core/cache/cache_helper.dart';
//
// class ApiInterceptor extends Interceptor {
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     options.headers[ApiKeys.token] =
//         CacheHelper().getData(key: ApiKeys.token) != null
//             ? 'Bearer ${CacheHelper().getData(key: ApiKeys.token)}'
//             : null;
//     super.onRequest(options, handler);
//   }
// }

import 'package:dio/dio.dart';
import 'package:islamic_app/core/api/api_keys.dart';
import 'package:islamic_app/core/cache/cache_helper.dart';
class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await CacheHelper().getData(key: ApiKeys.token);

    if (token != null) {
      options.headers[ApiKeys.authorization] = 'Bearer $token';
    }

    options.headers["Content-Type"] = "application/json";
    options.headers["Accept"] = "application/json";

    super.onRequest(options, handler);
  }
}
