import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_state/base_state.dart';
import 'package:mapsdata/core/config/exception/message_exception.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/presentation/features/recharge_card_printing/data/model/get_recharge_printing_response.dart';
import 'package:mapsdata/presentation/features/recharge_card_printing/data/repo/get_recharge_card_printing_repo.dart';

class GetRechargeCardPrintingNotifier
    extends AutoDisposeNotifier<BaseState<RechargeCardPrintingResponse>> {
  GetRechargeCardPrintingNotifier();

  late GetRechargeCardPrintingRepository _repository;

  @override
  BaseState<RechargeCardPrintingResponse> build() {
    _repository = ref.read(getRechargeCardPrintingRepositoryProvider);

    return BaseState<RechargeCardPrintingResponse>.initial();
  }

  Future<void> getRechargeCardPrinting() async {
    state = state.copyWith(state: LoadState.loading);

    try {
      final value = await _repository.getRechargeCardPrinting();

      if (value.status == 'failed') throw value.message?.toException ?? '';

      state = state.copyWith(state: LoadState.idle, data: (value.data));
    } catch (e) {
      state = state.copyWith(state: LoadState.idle);
    }
  }
}

final getRechargeCardPrintingNotifierProvider = NotifierProvider.autoDispose<
        GetRechargeCardPrintingNotifier,
        BaseState<RechargeCardPrintingResponse>>(
    GetRechargeCardPrintingNotifier.new);
