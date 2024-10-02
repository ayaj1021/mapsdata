import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/exception/message_exception.dart';
import 'package:mapsdata/core/database/local_storage_impl.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/presentation/features/login/data/models/login_request.dart';
import 'package:mapsdata/presentation/features/login/data/repository/login_repository.dart';
import 'package:mapsdata/presentation/features/login/presentation/notifier/login_state.dart';

class LoginNotifer extends AutoDisposeNotifier<LoginNotiferState> {
  LoginNotifer();
  late final LoginRepository _loginRepository;
  @override
  LoginNotiferState build() {
    _loginRepository = ref.read(loginRepositoryProvider);
    return LoginNotiferState.initial();
  }

  Future<void> login({
    required LoginRequest data,
    required void Function(String error) onError,
    required void Function(String message) onSuccess,
  }) async {
    try {
      state = state.copyWith(loginState: LoadState.loading);
      final value = await _loginRepository.login(
        data,
      );
      if (value.status == 'failed') throw value.message.toException;


      state = state.copyWith(loginState: LoadState.idle);
      await SecureStorage().saveUserToken(value.data!.user!.token.toString());
      await SecureStorage().saveUserApiKey(value.data!.user!.apikey.toString());
      onSuccess(value.message.toString());
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(loginState: LoadState.idle);
    }
  }

  // Future<void> _saveUser(LoginResponse res) async {
  //   final user = DSUser(
  //     email: res.email ?? '',
  //     firstName: res.firstName ?? '',
  //     lastName: res.lastName ?? '',
  //   );
  //   await ref.read(userRepositoryProvider).updateUser(user);
  // }

  // Future<void> _saveToken(Tokens token) async {
  //   await ref.read(userAuthRepositoryProvider).saveToken(token);
  // }

  // Future<void> _saveUserPassword(String password) async {
  //   await ref.read(userAuthRepositoryProvider).saveUserPassword(password);
  // }

  // Future<void> _saveCurrentState() async {
  //   await ref
  //       .read(userAuthRepositoryProvider)
  //       .saveCurrentState(CurrentState.onboarded);
  // }

  Future<void> logout({
    required void Function(String error) onError,
    required void Function() onSuccess,
  }) async {
    try {
      state = state.copyWith(logoutState: LoadState.loading);
      // final res = await _loginRepository.logout();
      //  if (!res.status) throw res.message.toException;
      state = state.copyWith(logoutState: LoadState.success);
      onSuccess();
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(loginState: LoadState.idle);
    }
  }
}

final loginNotifer =
    NotifierProvider.autoDispose<LoginNotifer, LoginNotiferState>(
  LoginNotifer.new,
);
