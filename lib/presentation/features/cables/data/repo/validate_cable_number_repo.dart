import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_response/base_response.dart';
import 'package:mapsdata/core/config/exception/app_exception.dart';
import 'package:mapsdata/data/remote_data_source/rest_client.dart';
import 'package:mapsdata/presentation/features/cables/data/model/validate_cable_number_request.dart';
import 'package:mapsdata/presentation/features/cables/data/model/validate_cable_number_response.dart';

class ValidateCableNumberRepository {
  ValidateCableNumberRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<ValidateCableNumberResponse>> validateCableNumber(
      ValidateCableNumberRequest request) async {
    try {
      final res = await _restClient.validateCableNumber(request);

      return BaseResponse(
          status: res.status.toString(), data: res, message: res.name);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final validateCableNumberRepositoryProvider =
    Provider<ValidateCableNumberRepository>(
  (ref) => ValidateCableNumberRepository(
    ref.read(restClientProvider),
  ),
);
