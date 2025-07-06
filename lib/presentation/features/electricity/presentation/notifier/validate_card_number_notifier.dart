import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_state/base_state.dart';
import 'package:mapsdata/core/config/exception/message_exception.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/presentation/features/electricity/data/model/validate_card_number_request.dart';
import 'package:mapsdata/presentation/features/electricity/data/model/validate_card_number_response.dart';
import 'package:mapsdata/presentation/features/electricity/data/repo/validate_card_number_repo.dart';

class ValidateCardNumberNotifier
    extends AutoDisposeNotifier<BaseState<ValidateCardNumberResponse>> {
  ValidateCardNumberNotifier();

  late ValidateCardNumberRepository _repository;

  @override
  BaseState<ValidateCardNumberResponse> build() {
    _repository = ref.read(validateCardNumberRepositoryProvider);

    return BaseState<ValidateCardNumberResponse>.initial();
  }

  Future<void> validateCardNumber({
    required ValidateCardNumberRequest request,
    required void Function(String message) onError,
    required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(state: LoadState.loading);

    try {
      final value = await _repository.validateCardNumber(request);

      if (value.status == 'failed') throw value.message?.toException ?? '';

      state = state.copyWith(state: LoadState.idle, data: (value.data));
      onSuccess(value.message ?? '');
    } catch (e) {
      state = state.copyWith(state: LoadState.idle);
      onError(e.toString());
    }
  }
}

final validateCardNumberNotifierProvider = NotifierProvider.autoDispose<
    ValidateCardNumberNotifier,
    BaseState<ValidateCardNumberResponse>>(ValidateCardNumberNotifier.new);
