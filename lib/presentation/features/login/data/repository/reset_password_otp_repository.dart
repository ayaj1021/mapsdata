// import 'package:digit_send/core/config/base_response/base_response.dart';
// import 'package:digit_send/core/config/exception/app_exception.dart';
// import 'package:digit_send/data/remote_data_source/rest_client.dart';
// import 'package:digit_send/presentation/features/login/data/models/reset_password_otp_request.dart';
// import 'package:digit_send/presentation/features/login/data/models/reset_password_otp_response.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:mapsdata/core/config/base_response/base_response.dart';
// import 'package:mapsdata/core/config/exception/app_exception.dart';
// import 'package:mapsdata/data/remote_data_source/rest_client.dart';
// import 'package:mapsdata/presentation/features/login/data/models/reset_password_otp_request.dart';
// import 'package:mapsdata/presentation/features/login/data/models/reset_password_otp_response.dart';

// class ResetPasswordOtpRepository {
//   ResetPasswordOtpRepository(this._client);
//   final RestClient _client;

//   Future<BaseResponse<VerifyResetPasswordOtpResponse>> resetPasswordOtp(
//     ResetPasswordOtpRequest resetPasswordOtpRequest,
//   ) async {
//     try {
//       // final response =
//       //     await _client.verifyResetPasswordOtp(resetPasswordOtpRequest);

//       // return response;
//     } on DioException catch (e) {
//       return AppException.handleError(e);
//     }
//   }
// }

// final resetPasswordOtpRepositoryProvider = Provider<ResetPasswordOtpRepository>(
//   (ref) => ResetPasswordOtpRepository(
//     ref.read(restClientProvider),
//   ),
// );
