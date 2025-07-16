import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_state/base_state.dart';
import 'package:mapsdata/core/config/exception/message_exception.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/presentation/features/electricity/data/model/get_discos_response.dart';
import 'package:mapsdata/presentation/features/electricity/data/repo/get_discos_repo.dart';

class GetDiscosNotifier
    extends AutoDisposeNotifier<BaseState<GetDiscosResponse>> {
  GetDiscosNotifier();

  late GetDiscosRepository _repository;

  @override
  BaseState<GetDiscosResponse> build() {
    _repository = ref.read(getDiscosRepositoryProvider);

    return BaseState<GetDiscosResponse>.initial();
  }

  Future<void> getDiscos({
    required void Function(String message, bool hasPin) onSuccess,
  }) async {
    state = state.copyWith(state: LoadState.loading);

    try {
      final value = await _repository.getDiscos();

      if (value.status == 'failed') throw value.message?.toException ?? '';

      state = state.copyWith(state: LoadState.idle, data: (value.data));
      onSuccess('', value.data?.pin ?? false);
    } catch (e) {
      state = state.copyWith(state: LoadState.idle);
    }
  }
}

final getDiscosNotifierProvider = NotifierProvider.autoDispose<
    GetDiscosNotifier, BaseState<GetDiscosResponse>>(GetDiscosNotifier.new);
