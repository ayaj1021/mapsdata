import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_response/base_response.dart';
import 'package:mapsdata/core/config/exception/app_exception.dart';
import 'package:mapsdata/data/remote_data_source/rest_client.dart';
import 'package:mapsdata/presentation/features/register/data/models/sign_up_request.dart';
import 'package:mapsdata/presentation/features/register/data/models/sign_up_response.dart';

class RegisterRepository {
  RegisterRepository(this._restClient);
  final RestClient _restClient;
  Future<BaseResponse<SignUpResponse>> signUp(SignUpRequest request) async {
    try {
      final response = await _restClient.signUp(request);
      return BaseResponse(
          status: response.status.toString(),
          data: response,
          message: response.message);
      //  return BaseResponse(status: 'success', data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final registerRepositoryProvider = Provider<RegisterRepository>(
  (ref) => RegisterRepository(
    ref.read(restClientProvider),
  ),
);
