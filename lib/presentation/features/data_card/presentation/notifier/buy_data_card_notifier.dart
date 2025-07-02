import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_state/base_state.dart';
import 'package:mapsdata/core/config/exception/message_exception.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/presentation/features/data_card/data/model/buy_data_card_request.dart';
import 'package:mapsdata/presentation/features/data_card/data/model/buy_data_card_response.dart';
import 'package:mapsdata/presentation/features/data_card/data/repository/buy_data_card_repo.dart';

class BuyDataCardNotifier
    extends AutoDisposeNotifier<BaseState<BuyDataCardResponse>> {
  BuyDataCardNotifier();

  late BuyDataCardRepository _repository;

  @override
  BaseState<BuyDataCardResponse> build() {
    _repository = ref.read(buyDataCardRepositoryProvider);

    return BaseState<BuyDataCardResponse>.initial();
  }

  Future<void> buyDataCard({
    required BuyDataCardRequest request,
    required void Function(String message) onError,
    required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(state: LoadState.loading);

    try {
      final value = await _repository.buyDataCard(request);

      if (value.status == 'failed') throw value.message?.toException ?? '';

      state = state.copyWith(state: LoadState.idle, data: (value.data));
      onSuccess(value.message ?? '');
    } catch (e) {
      state = state.copyWith(state: LoadState.idle);
      onError(e.toString());
    }
  }
}

final buyDataCardNotifierProvider = NotifierProvider.autoDispose<
    BuyDataCardNotifier,
    BaseState<BuyDataCardResponse>>(BuyDataCardNotifier.new);
