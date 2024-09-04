import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/exception/message_exception.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/presentation/features/login/data/models/forgot_password_request.dart';
import 'package:mapsdata/presentation/features/login/data/repository/forgot_password_repository.dart';
import 'package:mapsdata/presentation/features/login/presentation/notifier/forgot_password_state.dart';

class ForgotPasswordNotifier extends AutoDisposeNotifier<ForgotPasswordState> {
  ForgotPasswordNotifier();

  late final ForgotPasswordRepository _forgotPasswordRepository;
  // UserAuthRepository _userAuthRepository;
 // late final LocalStorage _localStorage;
  @override
  ForgotPasswordState build() {
    _forgotPasswordRepository = ref.read(forgotPasswordRepositoryProvider);
    return ForgotPasswordState.initial();
  }

  Future<void> forgotPassword({
    required ForgotPasswordRequest data,
    required void Function(String error) onError,
    required void Function() onSuccess,
  }) async {
    state = state.copyWith(forgotPasswordState: LoadState.loading);
    try {
      final value = await _forgotPasswordRepository.forgotPassword(
        data,
      );
      if (!value.status) throw value.message.toException;

      state = state.copyWith(forgotPasswordState: LoadState.idle);
      onSuccess();
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(forgotPasswordState: LoadState.idle);
    } 
  }

  // Future<void> saveEmail(String userEmail) async {
  //   await _localStorage.put(HiveKeys.userEmail, userEmail);
  // }
}

final forgotPasswordNotifer =
    NotifierProvider.autoDispose<ForgotPasswordNotifier, ForgotPasswordState>(
  ForgotPasswordNotifier.new,
);
