
import 'package:dio/dio.dart';
import 'package:mapsdata/core/config/base_response/base_response.dart';
import 'package:mapsdata/core/config/exception/logger.dart';
import 'package:mapsdata/core/utils/strings.dart';

class AppException implements Exception {
  static BaseResponse<T> handleError<T>(
    DioException e, {
    T? data,
    T Function(Map<String, dynamic>)? fromJsonT,
  }) {
    debugLog(e);
    if (e.response != null && DioExceptionType.badResponse == e.type) {
      if ((e.response?.statusCode ?? 0) >= 500) {
        return BaseResponse(
          status: false,
          message: Strings.serverError,
          data: data,
        );
      }
      if (e.response?.statusCode == 413) {
        return BaseResponse(
          status: false,
          message: 'File size too large',
          data: data,
        );
      }
      if (e.response?.data is Map<String, dynamic>) {
        debugLog(e.response?.data as Map<String, dynamic>);
        if (fromJsonT != null) {
          (e.response?.data as Map<String, dynamic>? ?? {})['data'] = fromJsonT(
            (e.response?.data as Map<String, dynamic>? ?? {})['data']
                    as Map<String, dynamic>? ??
                {},
          );
        }
        return BaseResponse.fromMap(
          e.response?.data as Map<String, dynamic>,
        );
      } else if (e.response?.data is String) {
        debugLog(e.response?.data);
        return BaseResponse(
          status: false,
          message: e.response?.data as String,
        );
      }
    }
    return BaseResponse(
      status: false,
      data: data,
      message: _mapException(e.type),
    );
  }

  static String _mapException(DioExceptionType? error) {
    if (DioExceptionType.connectionTimeout == error ||
        DioExceptionType.receiveTimeout == error ||
        DioExceptionType.sendTimeout == error) {
      return Strings.timeout;
    } else if (DioExceptionType.connectionError == error) {
      return Strings.connectionError;
    }
    return Strings.genericErrorMessage;
  }
}
