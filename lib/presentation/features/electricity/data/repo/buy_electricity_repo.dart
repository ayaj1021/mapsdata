import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_response/base_response.dart';
import 'package:mapsdata/core/config/exception/app_exception.dart';
import 'package:mapsdata/data/remote_data_source/rest_client.dart';
import 'package:mapsdata/presentation/features/electricity/data/model/buy_electricity_request.dart';
import 'package:mapsdata/presentation/features/electricity/data/model/buy_electricity_response.dart';

class BuyElectricityRepository {
  BuyElectricityRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<BuyElectricityResponse>> buyElectricity(
      BuyElectricityRequest request) async {
    try {
      final res = await _restClient.buyElectricity(request);

      return BaseResponse(
          status: res.status.toString(), data: res, message: res.message);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final buyElectricityRepositoryProvider = Provider<BuyElectricityRepository>(
  (ref) => BuyElectricityRepository(
    ref.read(restClientProvider),
  ),
);
