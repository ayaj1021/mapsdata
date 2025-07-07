import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_response/base_response.dart';
import 'package:mapsdata/core/config/exception/app_exception.dart';
import 'package:mapsdata/data/remote_data_source/rest_client.dart';
import 'package:mapsdata/presentation/features/bulk_sms/data/model/bulk_sms_request.dart';
import 'package:mapsdata/presentation/features/bulk_sms/data/model/bulk_sms_response.dart';

class BulkSmsRepository {
  BulkSmsRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<BulkSmsResponse>> bulkSms(BulkSmsRequest request) async {
    try {
      final res = await _restClient.bulkSms(request);

      return BaseResponse(
          status: res.status.toString(), data: res, message: res.message);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final bulkSmsRepositoryProvider = Provider<BulkSmsRepository>(
  (ref) => BulkSmsRepository(
    ref.read(restClientProvider),
  ),
);
