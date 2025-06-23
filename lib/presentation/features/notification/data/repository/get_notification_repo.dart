import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_response/base_response.dart';
import 'package:mapsdata/core/config/exception/app_exception.dart';
import 'package:mapsdata/data/remote_data_source/rest_client.dart';
import 'package:mapsdata/presentation/features/notification/data/model/get_notification_response.dart';

class NotificationRepository {
  NotificationRepository(this._restClient);
  final RestClient _restClient;

  Future<BaseResponse<NotificationResponse>> getNotification() async {
    try {
      final response = await _restClient.getNotifications();
      //  return BaseResponse(status: 'success', data: response);

      return BaseResponse(
          status: response.status.toString(),
          data: response,
          message: response.notification?.message ?? '');
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final getNotificationRepositoryProvider = Provider<NotificationRepository>(
  (ref) => NotificationRepository(
    ref.read(restClientProvider),
  ),
);
