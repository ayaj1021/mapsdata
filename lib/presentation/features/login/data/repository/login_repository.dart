import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_response/base_response.dart';
import 'package:mapsdata/core/config/exception/app_exception.dart';
import 'package:mapsdata/data/remote_data_source/rest_client.dart';
import 'package:mapsdata/presentation/features/login/data/models/login_request.dart';
import 'package:mapsdata/presentation/features/login/data/models/login_response.dart';

class LoginRepository {
  LoginRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<LoginResponse>> login(LoginRequest loginRequest) async {
    try {
      final response = await _restClient.login(loginRequest);
      return response;
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }

  // Future<BaseResponse> logout() async {
  //   try {
  //   //  return await _restClient.logout();
  //   } on DioException catch (e) {
  //     return AppException.handleError(e);
  //   }
  // }
}

final loginRepositoryProvider = Provider<LoginRepository>(
  (ref) => LoginRepository(
    ref.read(restClientProvider),
  ),
);
