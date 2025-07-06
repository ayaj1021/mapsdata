import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_response/base_response.dart';
import 'package:mapsdata/core/config/exception/app_exception.dart';
import 'package:mapsdata/data/remote_data_source/rest_client.dart';
import 'package:mapsdata/presentation/features/recharge_card_printing/data/model/get_recharge_printing_response.dart';

class GetRechargeCardPrintingRepository {
  GetRechargeCardPrintingRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<RechargeCardPrintingResponse>>
      getRechargeCardPrinting() async {
    try {
      final res = await _restClient.getRechargeCardPrinting();

      return BaseResponse(status: "success", data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final getRechargeCardPrintingRepositoryProvider =
    Provider<GetRechargeCardPrintingRepository>(
  (ref) => GetRechargeCardPrintingRepository(
    ref.read(restClientProvider),
  ),
);
