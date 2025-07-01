import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_response/base_response.dart';
import 'package:mapsdata/core/config/exception/app_exception.dart';
import 'package:mapsdata/data/remote_data_source/rest_client.dart';
import 'package:mapsdata/presentation/features/airtime_topup/data/model/fetch_airtime_list_model.dart';

class GetAirtimeRepository {
  GetAirtimeRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<GetAirtimePlansResponse>> getAllAirtimePlans() async {
    try {
      final res = await _restClient.getAirtimePlansDetails();

      return BaseResponse(status: res.status ?? "Success", data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final getAirtimePlansRepositoryProvider = Provider<GetAirtimeRepository>(
  (ref) => GetAirtimeRepository(
    ref.read(restClientProvider),
  ),
);
