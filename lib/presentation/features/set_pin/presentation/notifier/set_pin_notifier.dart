import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_state/base_state.dart';
import 'package:mapsdata/core/config/exception/message_exception.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/presentation/features/set_pin/data/model/set_pin_request.dart';
import 'package:mapsdata/presentation/features/set_pin/data/model/set_pin_response.dart';
import 'package:mapsdata/presentation/features/set_pin/data/repo/set_pin_repo.dart';

class SetPinNotifier extends AutoDisposeNotifier<BaseState<SetPinResponse>> {
  SetPinNotifier();

  late final SetPinRepository _repository;

  @override
  BaseState<SetPinResponse> build() {
    _repository = ref.read(setPinRepositoryProvider);
    return BaseState<SetPinResponse>.initial();
  }

  Future<void> setPin({
    required SetPinRequest data,
    required void Function(String message) onSuccess,
    required void Function(String message) onError,
  }) async {
    state = state.copyWith(state: LoadState.loading);
    try {
      final value = await _repository.setPin(data);
      if (value.status == 'failed') throw value.message.toException;

      state = state.copyWith(state: LoadState.idle, data: value.data);
      onSuccess(value.data?.message ?? '');
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(state: LoadState.idle);
    }
  }
}

final setPinNotifer =
    NotifierProvider.autoDispose<SetPinNotifier, BaseState<SetPinResponse>>(
  SetPinNotifier.new,
);
