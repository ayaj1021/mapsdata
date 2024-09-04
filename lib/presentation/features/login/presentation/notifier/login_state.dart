
import 'package:mapsdata/core/utils/enums.dart';

class LoginNotiferState {
  LoginNotiferState({
    required this.loginState,
    required this.logoutState,
  });

  final LoadState loginState;
  final LoadState logoutState;
  
  factory LoginNotiferState.initial() {
    return LoginNotiferState(
      loginState: LoadState.idle,  
      logoutState: LoadState.idle,
    );
  }
  LoginNotiferState copyWith({
    LoadState? loginState,
    LoadState? logoutState,
  }) {
    return LoginNotiferState(
      loginState: loginState ?? this.loginState,
      logoutState: logoutState?? this.logoutState,
    );
  }
}
