import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_state/base_state.dart';
import 'package:mapsdata/core/config/exception/message_exception.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/presentation/features/fund_account/data/model/link_bvn_nin_request.dart';
import 'package:mapsdata/presentation/features/fund_account/data/model/link_nin_bvn_response.dart';
import 'package:mapsdata/presentation/features/fund_account/data/repo/link_nin_bvn_repo.dart';

class LinkNinBvnNotifier
    extends AutoDisposeNotifier<BaseState<BvnLinkResponse>> {
  LinkNinBvnNotifier();

  late final LinkBvnNinRepository _repository;

  @override
  BaseState<BvnLinkResponse> build() {
    _repository = ref.read(linkNinBvnRepositoryProvider);
    return BaseState<BvnLinkResponse>.initial();
  }

  Future<void> linkBvn({
    required LinkBvnNinRequest request,
    required void Function(String message) onSuccess,
    required void Function(String message) onError,
  }) async {
    state = state.copyWith(state: LoadState.loading);
    try {
      final value = await _repository.linkBvn(request);
      if (value.status == 'failed') throw value.message.toException;

      state = state.copyWith(state: LoadState.idle, data: value.data);
      onSuccess(value.data?.message ?? '');
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(state: LoadState.idle);
    }
  }
}

final linkNinBvnNotifer = NotifierProvider.autoDispose<LinkNinBvnNotifier,
    BaseState<BvnLinkResponse>>(
  LinkNinBvnNotifier.new,
);
