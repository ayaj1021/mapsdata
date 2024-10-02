import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mapsdata/core/config/exception/logger.dart';
import 'package:mapsdata/core/database/local_storage_impl.dart';

class HeaderInterCeptor extends Interceptor {
  HeaderInterCeptor({
    required this.dio,
    required this.secureStorage,
    // required this.onTokenExpired,
  });
  final Dio dio;
  final SecureStorage secureStorage;
//  final void Function() onTokenExpired;

  final _authRoutes = [
    '/auth/login',
    '/auth/signup',
    '/auth/create-pin',
    '/auth/resend-otp',
    '/auth/verify-reset-otp',
    '/auth/forgot-password',
    '/auth/reset-password',
    '/auth/verify-signup-otp',
  ];
  @override
  FutureOr<dynamic> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final apikey = await secureStorage.getUserApiKey();
      // log("This is user accesstoken $apikey");

      debugLog('[TOKEN]$apikey');
      if (apikey.toString().isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $apikey';
        // options.headers['authorization'] = '$token';
        // options.headers['Cookie'] = 'accessToken=${token.token}';
      }
    } catch (e) {
      debugLog(e);
    }
    debugLog('[URL]${options.uri}');
    debugLog('[BODY] ${options.data}');
    debugLog('[METHOD] ${options.method}');
    debugLog('[QUERIES]${options.queryParameters}');
    debugLog('[HEADERS]${options.headers}');

    handler.next(options);
    return options;
  }

  @override
  FutureOr<dynamic> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // if (err.response != null && err.response!.statusCode == 401) {
    //   ref.read(logoutProvider.notifier).state = ActivityStatus.loggedOut;
    //   return;
    // }
    debugLog('[ERROR] ${err.requestOptions.uri}');
    debugLog('[ERROR] ${err.response}');
    if (err.response?.statusCode == 401 ||
        err.response?.statusCode == 403 &&
            !_authRoutes.contains(err.requestOptions.path)) {
      // onTokenExpired();
    }
    handler.next(err);
    return err;
  }

  @override
  FutureOr<dynamic> onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    debugLog(
      '[RESPONSE FROM ${response.requestOptions.path}]: ${response.data}',
    );
    handler.next(response);
    return response;
  }
}

// Future<void> _refreshToken(
//   DioException error,
//   ErrorInterceptorHandler handler,
//   Dio dio,
//   UserRepository userRepository,
//   Ref ref,
// ) async {
//   final refreshToken = userRepository.getRefreshToken();
//   try {
//     final r = await Dio().post<Response<Map<String, dynamic>?>>(
//       '${AuthStrings.baseUrl}/auth/refresh-token',
//       data: {
//         'refreshToken': refreshToken,
//       },
//     );
//     if (r.statusCode == 200) {
//       userRepository.saveToken(r.data['newAccessToken']);
//     }
//     return handleError(handler, error, dio);
//   } on DioException catch (_) {
//     // ref.read(homeNotifier.notifier).logout();
//     return;
//   }
// }

Future<void> handleError(
  ErrorInterceptorHandler handler,
  DioException err,
  Dio dio,
) async {
  final opts = Options(
    method: err.requestOptions.method,
    headers: err.requestOptions.headers,
  );
  final cloneReq = await dio.request<Map<String, dynamic>?>(
    err.requestOptions.path,
    options: opts,
    data: err.requestOptions.data,
    queryParameters: err.requestOptions.queryParameters,
  );

  return handler.resolve(cloneReq);
}
