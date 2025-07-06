import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_state/base_state.dart';
import 'package:mapsdata/core/config/exception/message_exception.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/presentation/features/recharge_card_printing/data/model/get_recharge_printing_response.dart';
import 'package:mapsdata/presentation/features/recharge_card_printing/data/model/recharge_card_printing_request.dart';
import 'package:mapsdata/presentation/features/recharge_card_printing/data/repo/recharge_card_printing_repo.dart';

class RechargeCardPrintingNotifier
    extends AutoDisposeNotifier<BaseState<RechargeCardPrintingResponse>> {
  RechargeCardPrintingNotifier();

  late RechargeCardPrintingRepository _repository;

  @override
  BaseState<RechargeCardPrintingResponse> build() {
    _repository = ref.read(rechargeCardPrintingRepositoryProvider);

    return BaseState<RechargeCardPrintingResponse>.initial();
  }

  Future<void> rechargeCardPrinting({
    required RechargeCardPrintingRequest request,
    required void Function(String message) onError,
    required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(state: LoadState.loading);

    try {
      final value = await _repository.rechargeCardPrinting(request);

      if (value.status == 'failed') throw value.message?.toException ?? '';

      state = state.copyWith(state: LoadState.idle, data: (value.data));
      onSuccess(value.message ?? '');
    } catch (e) {
      state = state.copyWith(state: LoadState.idle);
      onError(e.toString());
    }
  }
}

final rechargeCardPrintingNotifierProvider = NotifierProvider.autoDispose<
    RechargeCardPrintingNotifier,
    BaseState<RechargeCardPrintingResponse>>(RechargeCardPrintingNotifier.new);
