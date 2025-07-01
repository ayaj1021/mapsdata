import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_response/base_response.dart';
import 'package:mapsdata/core/config/exception/app_exception.dart';
import 'package:mapsdata/data/remote_data_source/rest_client.dart';
import 'package:mapsdata/presentation/features/data_card/data/model/get_data_cards_response.dart';

class GetDataCardsRepository {
  GetDataCardsRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<DataCardsResponse>> getDataCards() async {
    try {
      final res = await _restClient.getDataCards();

      return BaseResponse(status: "success", data: res);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final getDataCardsRepositoryProvider = Provider<GetDataCardsRepository>(
  (ref) => GetDataCardsRepository(
    ref.read(restClientProvider),
  ),
);
