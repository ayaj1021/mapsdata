import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_state/base_state.dart';
import 'package:mapsdata/core/config/exception/message_exception.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/presentation/features/fund_account/data/model/manual_funding_request.dart';
import 'package:mapsdata/presentation/features/fund_account/data/model/manual_funding_response.dart';
import 'package:mapsdata/presentation/features/fund_account/data/repo/manual_funding_repo.dart';

class ManualFundingNotifier
    extends AutoDisposeNotifier<BaseState<ManualFundingResponse>> {
  ManualFundingNotifier();

  late final ManualFundingRepository _repository;

  @override
  BaseState<ManualFundingResponse> build() {
    _repository = ref.read(manualFundingRepositoryProvider);
    return BaseState<ManualFundingResponse>.initial();
  }

  Future<void> manualFunding({
    required ManualFundingRequest request,
    required void Function(String message, AccountData data) onSuccess,
    required void Function(String message) onError,
  }) async {
    state = state.copyWith(state: LoadState.loading);
    try {
      final value = await _repository.manualFunding(request);
      if (value.status == 'failed') throw value.message.toException;

      state = state.copyWith(state: LoadState.idle, data: value.data);
      onSuccess(
          value.data?.message ?? '', value.data?.account ?? AccountData());
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(state: LoadState.idle);
    }
  }
}

final manualFundingNotifer = NotifierProvider.autoDispose<ManualFundingNotifier,
    BaseState<ManualFundingResponse>>(
  ManualFundingNotifier.new,
);
