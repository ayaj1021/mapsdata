import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_response/base_response.dart';
import 'package:mapsdata/core/config/exception/app_exception.dart';
import 'package:mapsdata/data/remote_data_source/rest_client.dart';
import 'package:mapsdata/presentation/features/sign_up/data/models/sign_up_request.dart';

class RegisterRepository {
  RegisterRepository(this._restClient);
  final RestClient _restClient;
  Future<BaseResponse<dynamic>> signUp(SignUpRequest request) async {
    try {
      return await _restClient.signUp(request);
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