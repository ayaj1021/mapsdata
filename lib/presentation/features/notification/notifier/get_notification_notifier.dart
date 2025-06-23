import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_state/base_state.dart';
import 'package:mapsdata/core/config/exception/message_exception.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/presentation/features/notification/data/model/get_notification_response.dart';
import 'package:mapsdata/presentation/features/notification/data/repository/get_notification_repo.dart';

class NotificationNotifier
    extends AutoDisposeNotifier<BaseState<NotificationResponse>> {
  NotificationNotifier();

  late final NotificationRepository _repository;

  @override
  BaseState<NotificationResponse> build() {
    _repository = ref.read(getNotificationRepositoryProvider);
    return BaseState<NotificationResponse>.initial();
  }

  Future<void> getNotification({
    required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(state: LoadState.loading);
    try {
      final value = await _repository.getNotification();
      if (value.status == 'failed') throw value.message.toException;

      state = state.copyWith(state: LoadState.idle, data: value.data);
      onSuccess(value.data?.notification?.message ?? '');
    } catch (e) {
      // onError(e.toString());
      state = state.copyWith(state: LoadState.idle);
    }
  }
}

final getNotificationNotifer = NotifierProvider.autoDispose<
    NotificationNotifier, BaseState<NotificationResponse>>(
  NotificationNotifier.new,
);
