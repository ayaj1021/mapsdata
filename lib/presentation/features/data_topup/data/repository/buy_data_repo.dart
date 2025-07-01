import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_response/base_response.dart';
import 'package:mapsdata/core/config/exception/app_exception.dart';
import 'package:mapsdata/data/remote_data_source/rest_client.dart';
import 'package:mapsdata/presentation/features/data_topup/data/model/buy_data_request.dart';
import 'package:mapsdata/presentation/features/data_topup/data/model/buy_data_response.dart';

class BuyDataRepository {
  BuyDataRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<BuyDataResponse>> buyData(BuyDataRequest request) async {
    try {
      final res = await _restClient.buyData(request);

      return BaseResponse(
          status: res.status.toString(), data: res, message: res.message);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final buyRepositoryProvider = Provider<BuyDataRepository>(
  (ref) => BuyDataRepository(
    ref.read(restClientProvider),
  ),
);
