import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_response/base_response.dart';
import 'package:mapsdata/core/config/exception/app_exception.dart';
import 'package:mapsdata/data/remote_data_source/rest_client.dart';
import 'package:mapsdata/presentation/features/login/data/models/reset_password_request.dart';
import 'package:mapsdata/presentation/features/login/data/models/reset_password_response.dart';

class ResetPasswordRepository {
  ResetPasswordRepository(this._client);
  final RestClient _client;

  Future<BaseResponse<ResetPasswordResponse>> resetPassword(
    ResetPasswordRequest resetPasswordRequest,
  ) async {
    try {
      // await Future<void>.delayed(const Duration(seconds: 2));
      //await _client.resetPassword(resetPasswordRequest);
      return const BaseResponse(status: true);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final resetPasswordRepositoryProvider = Provider<ResetPasswordRepository>(
  (ref) => ResetPasswordRepository(
    ref.read(restClientProvider),
  ),
);
