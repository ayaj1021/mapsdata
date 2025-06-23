import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_state/base_state.dart';
import 'package:mapsdata/core/config/exception/message_exception.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/presentation/features/fund_account/data/model/virtual_account_response.dart';
import 'package:mapsdata/presentation/features/fund_account/data/repo/virtual_account_repo.dart';

class VirtualAccountNotifier
    extends AutoDisposeNotifier<BaseState<VirtualAccountResponse>> {
  VirtualAccountNotifier();

  late final VirtualAccountRepository _repository;

  @override
  BaseState<VirtualAccountResponse> build() {
    _repository = ref.read(virtualAccountRepositoryProvider);
    return BaseState<VirtualAccountResponse>.initial();
  }

  Future<void> virtualAccount({
    required void Function(String message) onSuccess,
    required void Function(String message) onError,
  }) async {
    state = state.copyWith(state: LoadState.loading);
    try {
      final value = await _repository.virtualAccount();
      if (value.status == 'failed') throw value.message.toException;

      state = state.copyWith(state: LoadState.idle, data: value.data);
      onSuccess(value.data?.message ?? '');
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(state: LoadState.idle);
    }
  }
}

final virtualAccountNotifer = NotifierProvider.autoDispose<
    VirtualAccountNotifier, BaseState<VirtualAccountResponse>>(
  VirtualAccountNotifier.new,
);
