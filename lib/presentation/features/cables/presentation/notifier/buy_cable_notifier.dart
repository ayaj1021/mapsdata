import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_state/base_state.dart';
import 'package:mapsdata/core/config/exception/message_exception.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/presentation/features/cables/data/model/buy_cable_request.dart';
import 'package:mapsdata/presentation/features/cables/data/model/buy_cable_response.dart';
import 'package:mapsdata/presentation/features/cables/data/repo/buy_cable_repo.dart';

class BuyCableNotifier
    extends AutoDisposeNotifier<BaseState<BuyCableResponse>> {
  BuyCableNotifier();

  late BuyCableRepository _repository;

  @override
  BaseState<BuyCableResponse> build() {
    _repository = ref.read(buyCableRepositoryProvider);

    return BaseState<BuyCableResponse>.initial();
  }

  Future<void> buyCable({
    required BuyCableRequest request,
    required void Function(String message) onError,
    required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(state: LoadState.loading);

    try {
      final value = await _repository.buyCable(request);

      if (value.status == 'failed') throw value.message?.toException ?? '';

      state = state.copyWith(state: LoadState.idle, data: (value.data));
      onSuccess(value.message ?? '');
    } catch (e) {
      state = state.copyWith(state: LoadState.idle);
      onError(e.toString());
    }
  }
}

final buyCableNotifierProvider =
    NotifierProvider.autoDispose<BuyCableNotifier, BaseState<BuyCableResponse>>(
        BuyCableNotifier.new);
