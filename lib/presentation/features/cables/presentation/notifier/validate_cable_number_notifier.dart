import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_state/base_state.dart';
import 'package:mapsdata/core/config/exception/message_exception.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/presentation/features/cables/data/model/validate_cable_number_request.dart';
import 'package:mapsdata/presentation/features/cables/data/model/validate_cable_number_response.dart';
import 'package:mapsdata/presentation/features/cables/data/repo/validate_cable_number_repo.dart';

class ValidateCableNumberNotifier
    extends AutoDisposeNotifier<BaseState<ValidateCableNumberResponse>> {
  ValidateCableNumberNotifier();

  late ValidateCableNumberRepository _repository;

  @override
  BaseState<ValidateCableNumberResponse> build() {
    _repository = ref.read(validateCableNumberRepositoryProvider);

    return BaseState<ValidateCableNumberResponse>.initial();
  }

  Future<void> validateCableNumber({
    required ValidateCableNumberRequest request,
    required void Function(String message) onError,
    required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(state: LoadState.loading);

    try {
      final value = await _repository.validateCableNumber(request);

      if (value.status == 'failed') throw value.message?.toException ?? '';

      state = state.copyWith(state: LoadState.idle, data: (value.data));
      onSuccess(value.message ?? '');
    } catch (e) {
      state = state.copyWith(state: LoadState.idle);
      onError(e.toString());
    }
  }
}

final validateCableNumberNotifierProvider = NotifierProvider.autoDispose<
    ValidateCableNumberNotifier,
    BaseState<ValidateCableNumberResponse>>(ValidateCableNumberNotifier.new);
