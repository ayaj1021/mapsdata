import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mapsdata/core/extensions/build_context_extension.dart';
import 'package:mapsdata/core/extensions/overlay_extension.dart';
import 'package:mapsdata/core/extensions/space_extension.dart';
import 'package:mapsdata/core/extensions/text_theme_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/core/utils/strings.dart';
import 'package:mapsdata/core/utils/validators.dart';
import 'package:mapsdata/presentation/features/dashboard/widgets/dasboard.dart';
import 'package:mapsdata/presentation/features/login/data/models/login_request.dart';
import 'package:mapsdata/presentation/features/login/presentation/fingerprint_facialauth.dart';
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

  @override
  void initState() {
    _usernameController = TextEditingController(
        // text: kDebugMode ? 'xclusive+3@yopmail.com' : null,
        )
      ..addListener(_listener);
    _passwordController = TextEditingController(
        // text: kDebugMode ? 'Test@123' : null,
        )
      ..addListener(_listener);
    super.initState();
  }

  void _listener() {
    _isLoginEnabled.value = _usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
  }

  @override
  void dispose() {
    _isLoginEnabled.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                            // context.replaceNamed(Dashboard.routeName);
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

                Center(
                  child: FingerprintFacialauth(
                    onAuthenticated: (p0) {
                      _passwordController.text = p0;
                      _login();
                    },
                  ),
                ),
                130.hSpace,
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     GestureDetector(
                //       onTap: () => Navigator.pushReplacementNamed(
                //         context,
                //         Register.routeName,
                //       ),
                //       child: Text(
                //         Strings.signUp,
                //         style: context.textTheme.s14w400.copyWith(
                //           color: AppColors.secondaryColor,
                //         ),
                //       ),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.symmetric(horizontal: 24),
                //       child: Container(
                //         color: Colors.black,
                //         height: 20,
                //         width: 2,
                //       ),
                //     ),
                //     Text(
                //       Strings.privacy,
                //       style: context.textTheme.s14w400,
                //       selectionColor: AppColors.primary7C7794,
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login() {
    final data = LoginRequest(
      username: _usernameController.text.toLowerCase().trim(),
      password: _passwordController.text.trim(),
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
