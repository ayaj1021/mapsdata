import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_state/base_state.dart';
import 'package:mapsdata/core/config/exception/message_exception.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/presentation/features/fund_account/data/model/atm_funding_response.dart';
import 'package:mapsdata/presentation/features/fund_account/data/repo/atm_funding_repo.dart';

class AtmFundingNotifier
    extends AutoDisposeNotifier<BaseState<AtmFundingResponse>> {
  AtmFundingNotifier();

  late final AtmFundingRepository _repository;

  @override
  BaseState<AtmFundingResponse> build() {
    _repository = ref.read(atmFundingRepositoryProvider);
    return BaseState<AtmFundingResponse>.initial();
  }

  Future<void> atmFunding({
    required void Function(String message) onSuccess,
    required void Function(String message) onError,
  }) async {
    state = state.copyWith(state: LoadState.loading);
    try {
      final value = await _repository.atmFunding();
      if (value.status == 'failed') throw value.message.toException;

      state = state.copyWith(state: LoadState.idle, data: value.data);
      onSuccess(value.data?.message ?? '');
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(state: LoadState.idle);
    }
  }
}

final atmFundingNotifer = NotifierProvider.autoDispose<AtmFundingNotifier,
    BaseState<AtmFundingResponse>>(
  AtmFundingNotifier.new,
);
