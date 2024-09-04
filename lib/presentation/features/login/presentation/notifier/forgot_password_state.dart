
import 'package:mapsdata/core/utils/enums.dart';

class ForgotPasswordState {
  ForgotPasswordState({
    required this.inputValid,
    required this.forgotPasswordState,
  });

  final LoadState forgotPasswordState;
  final bool inputValid;
  factory ForgotPasswordState.initial() {
    return ForgotPasswordState(
      inputValid: false,
      forgotPasswordState: LoadState.idle,
    );
  }
  ForgotPasswordState copyWith({
    bool? inputValid,
    LoadState? forgotPasswordState,
  }) {
    return ForgotPasswordState(
      inputValid: inputValid ?? this.inputValid,
      forgotPasswordState: forgotPasswordState ?? this.forgotPasswordState,
    );
  }
}
