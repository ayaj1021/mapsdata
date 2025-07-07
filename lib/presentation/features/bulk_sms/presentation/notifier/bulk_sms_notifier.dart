import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_state/base_state.dart';
import 'package:mapsdata/core/config/exception/message_exception.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/presentation/features/bulk_sms/data/model/bulk_sms_request.dart';
import 'package:mapsdata/presentation/features/bulk_sms/data/model/bulk_sms_response.dart';
import 'package:mapsdata/presentation/features/bulk_sms/data/repo/bulk_sms_repo.dart';

class BulkSmsNotifier extends AutoDisposeNotifier<BaseState<BulkSmsResponse>> {
  BulkSmsNotifier();

  late BulkSmsRepository _repository;

  @override
  BaseState<BulkSmsResponse> build() {
    _repository = ref.read(bulkSmsRepositoryProvider);

    return BaseState<BulkSmsResponse>.initial();
  }

  Future<void> bulkSms({
    required BulkSmsRequest request,
    required void Function(String message) onError,
    required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(state: LoadState.loading);

    try {
      final value = await _repository.bulkSms(request);

      if (value.status == 'failed') throw value.message?.toException ?? '';

      state = state.copyWith(state: LoadState.idle, data: (value.data));
      onSuccess(value.message ?? '');
    } catch (e) {
      state = state.copyWith(state: LoadState.idle);
      onError(e.toString());
    }
  }
}

final bulkSmsNotifierProvider =
    NotifierProvider.autoDispose<BulkSmsNotifier, BaseState<BulkSmsResponse>>(
        BulkSmsNotifier.new);
