import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_response/base_response.dart';
import 'package:mapsdata/core/config/exception/app_exception.dart';
import 'package:mapsdata/data/remote_data_source/rest_client.dart';
import 'package:mapsdata/presentation/features/recharge_card_printing/data/model/get_recharge_printing_response.dart';
import 'package:mapsdata/presentation/features/recharge_card_printing/data/model/recharge_card_printing_request.dart';

class RechargeCardPrintingRepository {
  RechargeCardPrintingRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<RechargeCardPrintingResponse>> rechargeCardPrinting(
      RechargeCardPrintingRequest request) async {
    try {
      final res = await _restClient.rechargeCardPrinting(request);

      return BaseResponse(
          status: res.status.toString(), data: res, message: res.message);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final rechargeCardPrintingRepositoryProvider =
    Provider<RechargeCardPrintingRepository>(
  (ref) => RechargeCardPrintingRepository(
    ref.read(restClientProvider),
  ),
);
