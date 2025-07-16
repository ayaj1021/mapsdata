import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_response/base_response.dart';
import 'package:mapsdata/core/config/exception/app_exception.dart';
import 'package:mapsdata/data/remote_data_source/rest_client.dart';
import 'package:mapsdata/presentation/features/set_pin/data/model/set_pin_request.dart';
import 'package:mapsdata/presentation/features/set_pin/data/model/set_pin_response.dart';

class SetPinRepository {
  SetPinRepository(this._restClient);
  final RestClient _restClient;
  Future<BaseResponse<SetPinResponse>> setPin(SetPinRequest request) async {
    try {
      final response = await _restClient.setPin(request);
      return BaseResponse(
          status: response.status.toString(),
          data: response,
          message: response.message);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final setPinRepositoryProvider = Provider<SetPinRepository>(
  (ref) => SetPinRepository(
    ref.read(restClientProvider),
  ),
);
