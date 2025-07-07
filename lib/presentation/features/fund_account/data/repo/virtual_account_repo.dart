import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_response/base_response.dart';
import 'package:mapsdata/core/config/exception/app_exception.dart';
import 'package:mapsdata/data/remote_data_source/rest_client.dart';
import 'package:mapsdata/presentation/features/fund_account/data/model/virtual_account_response.dart';

class VirtualAccountRepository {
  VirtualAccountRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<VirtualAccountResponse>> virtualAccount() async {
    try {
      final response = await _restClient.virtualAccount();

      return BaseResponse(
          status: response.status.toString(),
          data: response,
          message: response.message ?? '');
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final virtualAccountRepositoryProvider = Provider<VirtualAccountRepository>(
  (ref) => VirtualAccountRepository(
    ref.read(restClientProvider),
  ),
);
