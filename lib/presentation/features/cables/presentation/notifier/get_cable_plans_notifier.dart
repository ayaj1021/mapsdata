import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_state/base_state.dart';
import 'package:mapsdata/core/config/exception/message_exception.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/presentation/features/cables/data/model/get_cable_plans_model.dart';
import 'package:mapsdata/presentation/features/cables/data/repo/get_cable_plans_repo.dart';

class GetCablePlansNotifier
    extends AutoDisposeNotifier<BaseState<CablePlansResponse>> {
  GetCablePlansNotifier();

  late GetCablePlansRepository _repository;

  @override
  BaseState<CablePlansResponse> build() {
    _repository = ref.read(getCablePlansRepositoryProvider);

    return BaseState<CablePlansResponse>.initial();
  }

  Future<void> getCablePlans() async {
    state = state.copyWith(state: LoadState.loading);

    try {
      final value = await _repository.getCablePlans();

      if (value.status == 'failed') throw value.message?.toException ?? '';

      state = state.copyWith(state: LoadState.idle, data: (value.data));
    } catch (e) {
      state = state.copyWith(state: LoadState.idle);
    }
  }
}

final getCablePlansNotifierProvider = NotifierProvider.autoDispose<
    GetCablePlansNotifier,
    BaseState<CablePlansResponse>>(GetCablePlansNotifier.new);
