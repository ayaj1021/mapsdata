import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_state/base_state.dart';
import 'package:mapsdata/core/config/exception/message_exception.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/presentation/features/airtime_topup/data/model/fetch_airtime_list_model.dart';
import 'package:mapsdata/presentation/features/airtime_topup/data/repository/fetch_airtime_list_repo.dart';

class GetAirtimePlansNotifier
    extends AutoDisposeNotifier<BaseState<GetAirtimePlansResponse>> {
  GetAirtimePlansNotifier();

  late GetAirtimeRepository _repository;

  @override
  BaseState<GetAirtimePlansResponse> build() {
    _repository = ref.read(getAirtimePlansRepositoryProvider);

    return BaseState<GetAirtimePlansResponse>.initial();
  }

  Future<void> getAirtimePlans(
      {required void Function(String message, bool hasPin) onSuccess}) async {
    state = state.copyWith(state: LoadState.loading);

    try {
      final value = await _repository.getAllAirtimePlans();

      if (value.status == 'failed') throw value.message?.toException ?? '';

      state = state.copyWith(state: LoadState.idle, data: (value.data));
      onSuccess('', value.data?.pin ?? false);
    } catch (e) {
      state = state.copyWith(state: LoadState.idle);
    }
  }
}

final getAirtimePlansNotifierProvider = NotifierProvider.autoDispose<
    GetAirtimePlansNotifier,
    BaseState<GetAirtimePlansResponse>>(GetAirtimePlansNotifier.new);
