import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_response/base_response.dart';
import 'package:mapsdata/core/config/exception/app_exception.dart';
import 'package:mapsdata/data/remote_data_source/rest_client.dart';
import 'package:mapsdata/presentation/features/result_checker/data/model/buy_exam_request.dart';
import 'package:mapsdata/presentation/features/result_checker/data/model/buy_exam_response.dart';

class BuyExamRepository {
  BuyExamRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<BuyExamResponse>> buyExam(BuyExamRequest request) async {
    try {
      final res = await _restClient.buyExam(request);

      return BaseResponse(
          status: res.status.toString(), data: res, message: res.message);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final buyExamRepositoryProvider = Provider<BuyExamRepository>(
  (ref) => BuyExamRepository(
    ref.read(restClientProvider),
  ),
);
