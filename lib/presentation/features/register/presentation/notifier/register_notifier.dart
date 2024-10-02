import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/exception/logger.dart';
import 'package:mapsdata/core/config/exception/message_exception.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/presentation/features/register/data/models/sign_up_request.dart';
import 'package:mapsdata/presentation/features/register/data/repository/register_repository.dart';
import 'package:mapsdata/presentation/features/register/presentation/notifier/register_state.dart';

class RegisterNotifier extends AutoDisposeNotifier<RegisterNotifierState> {
  RegisterNotifier();

  late RegisterRepository _registerRepository;
  //late UserAuthRepository _userAuthRepository;
 // late UserRepository _userRepository;
  @override
  RegisterNotifierState build() {
    _registerRepository = ref.read(registerRepositoryProvider);
   // _userAuthRepository = ref.read(userAuthRepositoryProvider);
    // _userRepository = ref.read(userRepositoryProvider);
    return RegisterNotifierState.initial();
  }

  void allInputValid({
    required bool firstNameValid,
    required bool lastNameValid,
    required bool userNameValid,
    required bool emailValid,
    required bool numberValid,
    required bool passwordValid,
    // required bool confirmPasswordValid,
  }) {
    state = state.copyWith(
        inputValid: firstNameValid &&
            lastNameValid &&
            userNameValid &&
            emailValid &&
            numberValid &&
            passwordValid
        // confirmPasswordValid
        );
  }

  Future<void> signUp({
    required SignUpRequest data,
    required void Function(String error) onError,
    required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(registerState: LoadState.loading);

    try {
      final value = await _registerRepository.signUp(data);
      debugLog(data);
      if (value.status == 'failed') throw value.message.toException;

      state = state.copyWith(registerState: LoadState.idle);
      onSuccess(value.message.toString());
    } catch (e) {
      onError(e.toString());
      state = state.copyWith(registerState: LoadState.idle);
    }
  }

  // Future<void> saveUser(LoginResponse res) async {
  //   final user = DSUser(
  //     email: res.email ?? '',
  //     firstName: res.firstName ?? '',
  //     lastName: res.lastName ?? '',
  //   );
  //   await _userRepository.updateUser(user);
  // }

  // Future<void> saveToken(Tokens token) async {
  //   await _userAuthRepository.saveToken(token);
  // }
}

final registerNotifier =
    NotifierProvider.autoDispose<RegisterNotifier, RegisterNotifierState>(
  RegisterNotifier.new,
);
