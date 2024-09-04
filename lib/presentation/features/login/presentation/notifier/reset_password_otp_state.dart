import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/presentation/features/login/data/models/reset_password_otp_response.dart';

class ResetPasswordOtpState {
  ResetPasswordOtpState({
    required this.inputValid,
    required this.resetPasswordOtpState,
    this.verifyResetPasswordOtpResponse,
  });
  factory ResetPasswordOtpState.initial() {
    return ResetPasswordOtpState(
      inputValid: false,
      resetPasswordOtpState: LoadState.idle,
    );
  }

  final LoadState resetPasswordOtpState;
  final bool inputValid;
  final VerifyResetPasswordOtpResponse? verifyResetPasswordOtpResponse;
  ResetPasswordOtpState copyWith({
    bool? inputValid,
    LoadState? resetPasswordOtpState,
    VerifyResetPasswordOtpResponse? verifyResetPasswordOtpResponse,
  }) {
    return ResetPasswordOtpState(
      inputValid: inputValid ?? this.inputValid,
      resetPasswordOtpState:
          resetPasswordOtpState ?? this.resetPasswordOtpState,
      verifyResetPasswordOtpResponse:
          verifyResetPasswordOtpResponse ?? this.verifyResetPasswordOtpResponse,
    );
  }
}
