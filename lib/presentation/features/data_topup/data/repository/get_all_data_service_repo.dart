import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_response/base_response.dart';
import 'package:mapsdata/core/config/exception/app_exception.dart';
import 'package:mapsdata/data/remote_data_source/rest_client.dart';
import 'package:mapsdata/presentation/features/data_topup/data/model/get_data_response_model.dart';

class GetAllDataPlansRepository {
  GetAllDataPlansRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<GetDataPlansResponse>> getAllDataPlans() async {
    try {
      final res = await _restClient.getDataPlansDetails();
      
      return BaseResponse(status: "success", data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final getAllDataPlansRepositoryProvider = Provider<GetAllDataPlansRepository>(
  (ref) => GetAllDataPlansRepository(
    ref.read(restClientProvider),
  ),
);
