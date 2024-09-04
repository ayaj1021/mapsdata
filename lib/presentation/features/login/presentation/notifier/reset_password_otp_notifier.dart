// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:mapsdata/core/utils/enums.dart';
// import 'package:mapsdata/presentation/features/login/data/models/reset_password_otp_request.dart';
// import 'package:mapsdata/presentation/features/login/data/repository/reset_password_otp_repository.dart';
// import 'package:mapsdata/presentation/features/login/presentation/notifier/reset_password_otp_state.dart';

// class ResetPasswordOtpNotifier
//     extends AutoDisposeNotifier<ResetPasswordOtpState> {
//   ResetPasswordOtpNotifier();

//  // late final ResetPasswordOtpRepository _resetPasswordOtpRepository;

//   @override
//   ResetPasswordOtpState build() {
//     _resetPasswordOtpRepository = ref.read(resetPasswordOtpRepositoryProvider);
//     return ResetPasswordOtpState.initial();
//   }

//   Future<void> verifyResetPasswordOtp({
//     required ResetPasswordOtpRequest data,
//     required void Function(String error) onError,
//     required void Function() onSuccess,
//   }) async {
//     state = state.copyWith(resetPasswordOtpState: LoadState.loading);
//     try {
//       final value = await _resetPasswordOtpRepository.resetPasswordOtp(
//         data,
//       );
//       if (!value.status) throw value.message.toException;

//       state = state.copyWith(
//         resetPasswordOtpState: LoadState.idle,
//         verifyResetPasswordOtpResponse: value.data,
//       );
//       onSuccess();
//     } catch (e) {
//       onError(e.toString());
//       state = state.copyWith(resetPasswordOtpState: LoadState.idle);
//     }
//   }
// }

// final resetPasswordOtpNotifer = NotifierProvider.autoDispose<
//     ResetPasswordOtpNotifier, ResetPasswordOtpState>(
//   ResetPasswordOtpNotifier.new,
// );
