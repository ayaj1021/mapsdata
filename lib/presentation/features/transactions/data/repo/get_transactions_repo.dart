import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_response/base_response.dart';
import 'package:mapsdata/core/config/exception/app_exception.dart';
import 'package:mapsdata/data/remote_data_source/rest_client.dart';
import 'package:mapsdata/presentation/features/transactions/data/model/get_transactions_response.dart';

class GetTransactionsRepository {
  GetTransactionsRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<TransactionResponse>> getTransactions({
    int? page,
    int entries = 25,
    String? search,
  }) async {
    try {
      final response = await _restClient.getTransactions(
        page: page,
        entries: entries,
        search: search,
      );

      return BaseResponse(status: 'Success', data: response, message: '');
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final getTransactionsRepositoryProvider = Provider<GetTransactionsRepository>(
  (ref) => GetTransactionsRepository(
    ref.read(restClientProvider),
  ),
);
