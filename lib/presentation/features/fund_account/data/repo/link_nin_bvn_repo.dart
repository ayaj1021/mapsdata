import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_response/base_response.dart';
import 'package:mapsdata/core/config/exception/app_exception.dart';
import 'package:mapsdata/data/remote_data_source/rest_client.dart';
import 'package:mapsdata/presentation/features/fund_account/data/model/link_bvn_nin_request.dart';
import 'package:mapsdata/presentation/features/fund_account/data/model/link_nin_bvn_response.dart';

class LinkBvnNinRepository {
  LinkBvnNinRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<BvnLinkResponse>> linkBvn(
      LinkBvnNinRequest request) async {
    try {
      final response = await _restClient.linkNinBvn(request);
      //  return BaseResponse(status: 'success', data: response);

      return BaseResponse(
          status: response.status.toString(),
          data: response,
          message: response.message);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final linkNinBvnRepositoryProvider = Provider<LinkBvnNinRepository>(
  (ref) => LinkBvnNinRepository(
    ref.read(restClientProvider),
  ),
);
