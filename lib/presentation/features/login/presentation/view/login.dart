import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mapsdata/core/config/security/biometrics.dart';
import 'package:mapsdata/core/database/local_storage_impl.dart';
import 'package:mapsdata/core/extensions/build_context_extension.dart';
import 'package:mapsdata/core/extensions/overlay_extension.dart';
import 'package:mapsdata/core/extensions/space_extension.dart';
import 'package:mapsdata/core/extensions/text_theme_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/core/utils/strings.dart';
import 'package:mapsdata/core/utils/validators.dart';
import 'package:mapsdata/presentation/features/dashboard/widgets/dashboard.dart';
import 'package:mapsdata/presentation/features/login/data/models/login_request.dart';
import 'package:mapsdata/presentation/features/login/presentation/notifier/login_notifier.dart';
import 'package:mapsdata/presentation/features/login/presentation/view/forgot_password.dart';
import 'package:mapsdata/presentation/features/register/presentation/view/register.dart';
import 'package:mapsdata/presentation/general_widgets/app_button.dart';
import 'package:mapsdata/presentation/general_widgets/digit_send_form_field.dart';
import 'package:mapsdata/presentation/general_widgets/digit_send_password_field.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});
  static const routeName = '/login';

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final ValueNotifier<bool> _isLoginEnabled = ValueNotifier(false);
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  final _secureStorage = SecureStorage();
  bool biometricsAvailable = false;
  bool showBiometrics = false;
  String debugInfo = '';
  bool hasLoggedIn = true;

  @override
  void initState() {
    _usernameController = TextEditingController()..addListener(_listener);
    _passwordController = TextEditingController()..addListener(_listener);
    getUserLoggedIn();
    super.initState();
    _initializeBiometrics();
  }

  void _listener() {
    _isLoginEnabled.value = _usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
  }

  getUserLoggedIn() async {
    hasLoggedIn = await _secureStorage.getHasLoggedIn();
  }

  @override
  void dispose() {
    _isLoginEnabled.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _initializeBiometrics() async {
    try {
      final canUseBiometrics = await Biometrics.canDoBiometrics();
      final savedEmail = await _secureStorage.getUserEmail();
      final savedPassword = await _secureStorage.getUserPassword();

      setState(() {
        biometricsAvailable = canUseBiometrics;
        // Show biometrics if available and user has previously saved credentials
        showBiometrics = canUseBiometrics

            // &&
            //     savedEmail != null &&
            //     savedEmail.isNotEmpty &&
            //     savedPassword != null &&
            //     savedPassword.isNotEmpty
            ;

        debugInfo = '''
Biometrics Available: $canUseBiometrics
Saved Email: ${savedEmail?.isNotEmpty == true ? "✅" : "❌"}
Saved Password: ${savedPassword?.isNotEmpty == true ? "✅" : "❌"}
Show Biometrics: $showBiometrics
        ''';
      });

      // If biometrics are available and credentials are saved, pre-fill the form
      if (showBiometrics && savedEmail != null && savedPassword != null) {
        _usernameController.text = savedEmail;
        // Don't pre-fill password for security, but store it for biometric auth
        _authenticateWithBiometrics();
      }
    } catch (e) {
      setState(() {
        biometricsAvailable = false;
        showBiometrics = false;
      });
    }
  }

  Future<void> _authenticateWithBiometrics() async {
    try {
      final biometrics = ref.read(biometricsProvider);
      final authenticated =
          await biometrics.performAuth('Please verify your identity to login');

      if (authenticated) {
        // Get saved credentials
        final savedEmail = await _secureStorage.getUserEmail();
        final savedPassword = await _secureStorage.getUserPassword();
        log('email $savedEmail, password $savedPassword');

        if (savedEmail != null && savedPassword != null) {
          // Auto-fill and login
          _usernameController.text = savedEmail;
          _passwordController.text = savedPassword;
          _fingerPrintlogin();
        } else {
          if (mounted) {
            context.showError(message: 'No saved credentials found');
          }
        }
      }
    } catch (e) {
      if (mounted) {
        context.showError(message: 'Biometric authentication failed');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                40.hSpace,
                Text(
                  Strings.welcome,
                  style: context.textTheme.s24w700,
                ),
                const Text(
                  Strings.nameWelcome,
                ),
                70.hSpace,
                DSFormfield(
                    controller: _usernameController,
                    validateFunction: Validators.notEmpty(),
                    hintText: 'Username',
                    prefixIcon: const Icon(Icons.person)

                    // SvgPicture.asset(
                    //   'assets/icons/person.svg',
                    //   fit: BoxFit.scaleDown,
                    // ),
                    ),
                DSPasswordField(
                  controller: _passwordController,
                  validateFunction: Validators.notEmpty(),
                  hintText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: SvgPicture.asset(
                    'assets/icons/eye.svg',
                    fit: BoxFit.scaleDown,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.pushNamed<void>(ForgotPassword.routeName);
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${Strings.forgotPassword}?',
                      style: context.textTheme.s12w400.copyWith(
                        color: AppColors.primary433C65,
                      ),
                    ),
                  ),
                ),
                70.hSpace,
                ValueListenableBuilder(
                  valueListenable: _isLoginEnabled,
                  builder: (context, r, c) {
                    return Consumer(
                      builder: (context, re, c) {
                        final isLoading = re.watch(
                          loginNotifer.select((v) => v.loginState.isLoading),
                        );
                        return MapsDataSendButton(
                          isLoading: isLoading,
                          isEnabled: r && !isLoading,
                          onTap: () {
                            _login();
                          },
                          title: Strings.login,
                        );
                      },
                    );
                  },
                ),
                28.hSpace,
                Row(
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: Strings.dontHaveAnAccount,
                          style: context.textTheme.s12w400
                              .copyWith(color: AppColors.primary1D1446),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.pushNamed(Register.routeName);
                                },
                              text: Strings.register,
                              style: context.textTheme.s12w700
                                  .copyWith(color: AppColors.primaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (hasLoggedIn && biometricsAvailable)
                  Center(
                    child: GestureDetector(
                        onTap: () {
                          _authenticateWithBiometrics();
                        },
                        child:
                            SvgPicture.asset('assets/icons/finger-print.svg')),
                  ),
                130.hSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login() async {
    final data = LoginRequest(
      username: _usernameController.text.trim(),
      password: _passwordController.text.trim(),
    );

    await _secureStorage.saveUserEmail(_usernameController.text.trim());
    await _secureStorage.saveUserPassword(_passwordController.text.trim());
    ref.read(loginNotifer.notifier).login(
          data: data,
          onError: (error) {
            context.showError(message: error);
          },
          onSuccess: (message) async {
            context.showSuccess(message: ' Authentication successful');
            _isLoginEnabled.value = false;
            context.replaceAll(Dashboard.routeName);
            await _secureStorage.saveHasLoggedIn(true);
          },
        );
  }

  void _fingerPrintlogin() async {
    final userName = await _secureStorage.getUserEmail();
    final password = await _secureStorage.getUserPassword();

    final data = LoginRequest(
      username: userName ?? '',
      password: password ?? '',
    );

    ref.read(loginNotifer.notifier).login(
          data: data,
          onError: (error) {
            context.showError(message: error);
          },
          onSuccess: (message) {
            context.showSuccess(message: ' Authentication successful');
            _isLoginEnabled.value = false;

            context.replaceAll(Dashboard.routeName);
          },
        );
  }
}
