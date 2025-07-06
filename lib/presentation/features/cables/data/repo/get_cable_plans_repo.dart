import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_response/base_response.dart';
import 'package:mapsdata/core/config/exception/app_exception.dart';
import 'package:mapsdata/data/remote_data_source/rest_client.dart';
import 'package:mapsdata/presentation/features/cables/data/model/get_cable_plans_model.dart';

class GetCablePlansRepository {
  GetCablePlansRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<CablePlansResponse>> getCablePlans() async {
    try {
      final res = await _restClient.getCablePlans();

      return BaseResponse(status: "success", data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final getCablePlansRepositoryProvider = Provider<GetCablePlansRepository>(
  (ref) => GetCablePlansRepository(
    ref.read(restClientProvider),
  ),
);
