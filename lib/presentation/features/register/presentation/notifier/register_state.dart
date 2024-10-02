
import 'package:mapsdata/core/utils/enums.dart';

class RegisterNotifierState {
  RegisterNotifierState({
    required this.inputValid,
    required this.registerState,
  });
  factory RegisterNotifierState.initial() {
    return RegisterNotifierState(
      inputValid: false,
      registerState: LoadState.idle,
    );
  }
  final bool inputValid;
  final LoadState registerState;
  RegisterNotifierState copyWith({
    bool? inputValid,
    LoadState? registerState,
  }) {
    return RegisterNotifierState(
      inputValid: inputValid ?? this.inputValid,
      registerState: registerState ?? this.registerState,
    );
  }
}
