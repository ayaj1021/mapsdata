import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_response/base_response.dart';
import 'package:mapsdata/core/config/exception/app_exception.dart';
import 'package:mapsdata/data/remote_data_source/rest_client.dart';
import 'package:mapsdata/presentation/features/airtime_topup/data/model/buy_airtime_request.dart';
import 'package:mapsdata/presentation/features/airtime_topup/data/model/buy_airtime_response.dart';

class BuyAirtimeRepository {
  BuyAirtimeRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<AirtimeResponse>> buyAirtime(
      BuyAirtimeRequest airtimeRequest) async {
    try {
      final response = await _restClient.buyAirtime(airtimeRequest);
      //  return BaseResponse(status: 'success', data: response);

      return BaseResponse(
          status: response.status.toString(),
          data: response,
          message: response.message);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final buyAirtimeRepositoryProvider = Provider<BuyAirtimeRepository>(
  (ref) => BuyAirtimeRepository(
    ref.read(restClientProvider),
  ),
);
