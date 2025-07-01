import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_response/base_response.dart';
import 'package:mapsdata/core/config/exception/app_exception.dart';
import 'package:mapsdata/data/remote_data_source/rest_client.dart';
import 'package:mapsdata/presentation/features/result_checker/data/model/get_all_exams_model.dart';

class GetResultServicesRepository {
  GetResultServicesRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<ExamResponse>> getResultServices() async {
    try {
      final res = await _restClient.getResultServices();

      return BaseResponse(status: res.status ?? "Success", data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final getResultServicesRepositoryProvider =
    Provider<GetResultServicesRepository>(
  (ref) => GetResultServicesRepository(
    ref.read(restClientProvider),
  ),
);
