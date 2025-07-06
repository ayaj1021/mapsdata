import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_response/base_response.dart';
import 'package:mapsdata/core/config/exception/app_exception.dart';
import 'package:mapsdata/data/remote_data_source/rest_client.dart';
import 'package:mapsdata/presentation/features/electricity/data/model/get_discos_response.dart';

class GetDiscosRepository {
  GetDiscosRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<GetDiscosResponse>> getDiscos() async {
    try {
      final res = await _restClient.getDiscos();

      return BaseResponse(status: "success", data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final getDiscosRepositoryProvider = Provider<GetDiscosRepository>(
  (ref) => GetDiscosRepository(
    ref.read(restClientProvider),
  ),
);
