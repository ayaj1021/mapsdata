import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_state/base_state.dart';
import 'package:mapsdata/core/config/exception/message_exception.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/presentation/features/airtime_topup/data/model/buy_airtime_request.dart';
import 'package:mapsdata/presentation/features/airtime_topup/data/model/buy_airtime_response.dart';
import 'package:mapsdata/presentation/features/airtime_topup/data/repository/buy_airtime_repository.dart';

class BuyAirtimeNotifier
    extends AutoDisposeNotifier<BaseState<BuyAirtimeResponse>> {
  BuyAirtimeNotifier();

  late BuyAirtimeRepository _repository;

  @override
  BaseState<BuyAirtimeResponse> build() {
    _repository = ref.read(buyAirtimeRepositoryProvider);

    return BaseState<BuyAirtimeResponse>.initial();
  }

  Future<void> buyAirtime({
    required BuyAirtimeRequest request,
    required void Function(String message) onError,
    required void Function(String message, BuyAirtimeResponse response)
        onSuccess,
  }) async {
    state = state.copyWith(state: LoadState.loading);

    try {
      final value = await _repository.buyAirtime(request);

      if (value.status == 'failed') throw value.message?.toException ?? '';

      state = state.copyWith(state: LoadState.idle, data: (value.data));
      onSuccess(value.message ?? '', value.data ?? BuyAirtimeResponse());
    } catch (e) {
      state = state.copyWith(state: LoadState.idle);
      onError(e.toString());
    }
  }
}

final buyAirtimeNotifierProvider = NotifierProvider.autoDispose<
    BuyAirtimeNotifier, BaseState<BuyAirtimeResponse>>(BuyAirtimeNotifier.new);
