import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_state/base_state.dart';
import 'package:mapsdata/core/config/exception/message_exception.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/presentation/features/data_card/data/model/get_data_cards_response.dart';
import 'package:mapsdata/presentation/features/data_card/data/repository/get_data_cards_list_repo.dart';

class GetDataCardsNotifier
    extends AutoDisposeNotifier<BaseState<DataCardsResponse>> {
  GetDataCardsNotifier();

  late GetDataCardsRepository _repository;

  @override
  BaseState<DataCardsResponse> build() {
    _repository = ref.read(getDataCardsRepositoryProvider);

    return BaseState<DataCardsResponse>.initial();
  }

  Future<void> getAllDataPlans() async {
    state = state.copyWith(state: LoadState.loading);

    try {
      final value = await _repository.getDataCards();

      if (value.status == 'failed') throw value.message?.toException ?? '';

      state = state.copyWith(state: LoadState.idle, data: (value.data));
    } catch (e) {
      state = state.copyWith(state: LoadState.idle);
    }
  }
}

final getDataCardsNotifierProvider = NotifierProvider.autoDispose<
    GetDataCardsNotifier,
    BaseState<DataCardsResponse>>(GetDataCardsNotifier.new);
