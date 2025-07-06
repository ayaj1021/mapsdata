import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_state/base_state.dart';
import 'package:mapsdata/core/config/exception/message_exception.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/presentation/features/electricity/data/model/buy_electricity_request.dart';
import 'package:mapsdata/presentation/features/electricity/data/model/buy_electricity_response.dart';
import 'package:mapsdata/presentation/features/electricity/data/repo/buy_electricity_repo.dart';

class BuyElectricityNotifier
    extends AutoDisposeNotifier<BaseState<BuyElectricityResponse>> {
  BuyElectricityNotifier();

  late BuyElectricityRepository _repository;

  @override
  BaseState<BuyElectricityResponse> build() {
    _repository = ref.read(buyElectricityRepositoryProvider);

    return BaseState<BuyElectricityResponse>.initial();
  }

  Future<void> buyElectricity({
    required BuyElectricityRequest request,
    required void Function(String message) onError,
    required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(state: LoadState.loading);

    try {
      final value = await _repository.buyElectricity(request);

      if (value.status == 'failed') throw value.message?.toException ?? '';

      state = state.copyWith(state: LoadState.idle, data: (value.data));
      onSuccess(value.message ?? '');
    } catch (e) {
      state = state.copyWith(state: LoadState.idle);
      onError(e.toString());
    }
  }
}

final buyElectricityNotifierProvider = NotifierProvider.autoDispose<
    BuyElectricityNotifier,
    BaseState<BuyElectricityResponse>>(BuyElectricityNotifier.new);
