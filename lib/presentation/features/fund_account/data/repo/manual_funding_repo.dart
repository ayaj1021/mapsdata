import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_response/base_response.dart';
import 'package:mapsdata/core/config/exception/app_exception.dart';
import 'package:mapsdata/data/remote_data_source/rest_client.dart';
import 'package:mapsdata/presentation/features/fund_account/data/model/manual_funding_request.dart';
import 'package:mapsdata/presentation/features/fund_account/data/model/manual_funding_response.dart';

class ManualFundingRepository {
  ManualFundingRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<ManualFundingResponse>> manualFunding(
      ManualFundingRequest request) async {
    try {
      final response = await _restClient.manualFunding(request);

      return BaseResponse(
        status: response.status.toString(),
        data: response,
        message: response.message,
      );
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final manualFundingRepositoryProvider = Provider<ManualFundingRepository>(
  (ref) => ManualFundingRepository(
    ref.read(restClientProvider),
  ),
);
