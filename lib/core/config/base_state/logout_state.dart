import 'package:mapsdata/core/utils/enums.dart';

class LogoutNotiferState {
  LogoutNotiferState({
    required this.logOut,
    required this.homeSessionState,
  });

  final LoadState logOut;
  final HomeSessionState homeSessionState;

  factory LogoutNotiferState.initial() {
    return LogoutNotiferState(
        logOut: LoadState.idle, homeSessionState: HomeSessionState.initial);
  }
  LogoutNotiferState copyWith(
      {LoadState? logOut, HomeSessionState? homeSessionState}) {
    return LogoutNotiferState(
      logOut: logOut ?? this.logOut,
      homeSessionState: homeSessionState ?? this.homeSessionState,
    );
  }
}
