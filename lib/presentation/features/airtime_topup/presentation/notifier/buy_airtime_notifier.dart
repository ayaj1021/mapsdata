import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/exception/message_exception.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/presentation/features/airtime_topup/data/model/buy_airtime_request.dart';
import 'package:mapsdata/presentation/features/airtime_topup/data/repository/buy_airtime_repository.dart';
import 'package:mapsdata/presentation/features/airtime_topup/presentation/notifier/buy_airtime_notifier_state.dart';

class BuyAirtimeNotifier extends AutoDisposeNotifier<BuyAirtimeNotiferState> {
  BuyAirtimeNotifier();
  late final BuyAirtimeRepository _buyAirtimeRepository;
  @override
  BuyAirtimeNotiferState build() {
    _buyAirtimeRepository = ref.read(buyAirtimeRepositoryProvider);
    return BuyAirtimeNotiferState.initial();
  }

  Future<void> login({
    required BuyAirtimeRequest data,
    required void Function(String error) onError,
    required void Function(String message) onSuccess,
  }) async {
    try {
      state = state.copyWith(buyAirtimeState: LoadState.loading);
      final value = await _buyAirtimeRepository.buyAirtime(
        data,
      );
      if (value.status == 'failed') throw value.message.toException;
      log(value.message.toString());

      state = state.copyWith(buyAirtimeState: LoadState.idle);

      onSuccess(value.message.toString());
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(buyAirtimeState: LoadState.idle);
    }
  }
}

final buyAirtimeNotifer =
    NotifierProvider.autoDispose<BuyAirtimeNotifier, BuyAirtimeNotiferState>(
  BuyAirtimeNotifier.new,
);
