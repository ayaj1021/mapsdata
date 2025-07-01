import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_state/base_state.dart';
import 'package:mapsdata/core/config/exception/message_exception.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/presentation/features/data_topup/data/model/buy_data_request.dart';
import 'package:mapsdata/presentation/features/data_topup/data/model/buy_data_response.dart';
import 'package:mapsdata/presentation/features/data_topup/data/repository/buy_data_repo.dart';

class BuyDataNotifier extends AutoDisposeNotifier<BaseState<BuyDataResponse>> {
  BuyDataNotifier();

  late BuyDataRepository _repository;

  @override
  BaseState<BuyDataResponse> build() {
    _repository = ref.read(buyRepositoryProvider);

    return BaseState<BuyDataResponse>.initial();
  }

  Future<void> buyData({
    required BuyDataRequest request,
    required void Function(String message) onError,
    required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(state: LoadState.loading);

    try {
      final value = await _repository.buyData(request);

      if (value.status == 'failed') throw value.message?.toException ?? '';

      state = state.copyWith(state: LoadState.idle, data: (value.data));
      onSuccess(value.message ?? '');
    } catch (e) {
      state = state.copyWith(state: LoadState.idle);
      onError(e.toString());
    }
  }
}

final buyDataNotifierProvider =
    NotifierProvider.autoDispose<BuyDataNotifier, BaseState<BuyDataResponse>>(
        BuyDataNotifier.new);
