import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/presentation/features/login/data/models/reset_password_response.dart';

class ResetPasswordState {
  ResetPasswordState({
    required this.inputValid,
    required this.resetPasswordState,
    this.resetPasswordResponse,
  });
  factory ResetPasswordState.initial() {
    return ResetPasswordState(
      inputValid: false,
      resetPasswordState: LoadState.idle,
    );
  }

  final LoadState resetPasswordState;
  final bool inputValid;
  final ResetPasswordResponse? resetPasswordResponse;
  ResetPasswordState copyWith({
    bool? inputValid,
    LoadState? resetPasswordState,
    ResetPasswordResponse? resetPasswordResponse,
  }) {
    return ResetPasswordState(
      inputValid: inputValid ?? this.inputValid,
      resetPasswordState:
          resetPasswordState ?? this.resetPasswordState,
     resetPasswordResponse:     resetPasswordResponse ?? this.resetPasswordResponse,
    );
  }
}
