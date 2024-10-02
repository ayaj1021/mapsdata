import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapsdata/core/extensions/build_context_extension.dart';
import 'package:mapsdata/core/extensions/overlay_extension.dart';
import 'package:mapsdata/core/extensions/space_extension.dart';
import 'package:mapsdata/core/extensions/text_theme_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/core/utils/strings.dart';
import 'package:mapsdata/core/utils/validators.dart';
import 'package:mapsdata/presentation/features/login/presentation/view/login.dart';
import 'package:mapsdata/presentation/features/register/data/models/sign_up_request.dart';
import 'package:mapsdata/presentation/features/register/presentation/notifier/register_notifier.dart';
import 'package:mapsdata/presentation/general_widgets/app_button.dart';
import 'package:mapsdata/presentation/general_widgets/digit_send_email_field.dart';
import 'package:mapsdata/presentation/general_widgets/digit_send_form_field.dart';
import 'package:mapsdata/presentation/general_widgets/digit_send_password_field.dart';

class Register extends ConsumerStatefulWidget {
  const Register({super.key});

  static const routeName = '/register';

  @override
  ConsumerState<Register> createState() => _RegisterState();
}

class _RegisterState extends ConsumerState<Register> {
  late TextEditingController _emailAddressController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _firstNamecontroller;
  late TextEditingController _lastNamecontroller;
  late TextEditingController _usernamecontroller;
  late TextEditingController _phoneNumbercontroller;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailAddressController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNamecontroller.dispose();
    _lastNamecontroller.dispose();
    _usernamecontroller.dispose();
    _phoneNumbercontroller.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _emailAddressController = TextEditingController()
      ..addListener(_validateInput);
    _passwordController = TextEditingController()..addListener(_validateInput);
    _firstNamecontroller = TextEditingController()..addListener(_validateInput);
    _lastNamecontroller = TextEditingController()..addListener(_validateInput);
    _usernamecontroller = TextEditingController()..addListener(_validateInput);
    _phoneNumbercontroller = TextEditingController()
      ..addListener(_validateInput);
    _confirmPasswordController = TextEditingController()
      ..addListener(_validateInput);
    //  _gendercontroller = ValueNotifier(null)..addListener(_validateInput);
  }

  void _validateInput() {
    ref.read(registerNotifier.notifier).allInputValid(
          firstNameValid: Validators.name()(_firstNamecontroller.text) == null,
          lastNameValid: Validators.name()(_lastNamecontroller.text) == null,
          userNameValid: Validators.name()(_usernamecontroller.text) == null,
          emailValid: Validators.email()(_emailAddressController.text) == null,
          numberValid: Validators.phone()(_phoneNumbercontroller.text) == null,
          passwordValid: Validators.password()(_passwordController.text) ==
                  null &&
              Validators.password()(_confirmPasswordController.text) == null &&
              _passwordController.text == _confirmPasswordController.text,
        );
  }

  void _signUp() {
    // print('xclusive@gmail.com'.redactedEmail);
    ref.read(registerNotifier.notifier).signUp(
          data: SignUpRequest(
            firstname: _firstNamecontroller.text.trim(),
            lastname: _lastNamecontroller.text.trim(),
            email: _emailAddressController.text.trim(),
            username: _usernamecontroller.text.trim(),
            number: _phoneNumbercontroller.text.trim(),
            password: _passwordController.text.trim(),
            confirmPassword: _confirmPasswordController.text.trim(),
          ),
          onError: (error) {
            context.showError(message: error);
          },
          onSuccess: (message) {
          //  context.hideOverLay();
            context.showSuccess(
                message: 'Registration has been completed successfully.');
            context.replaceNamed(Login.routeName);
            // ..push(

            // );
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              onChanged: () => setState(() {}),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  40.hSpace,
                  Text(
                    Strings.register,
                    style: context.textTheme.s32w600,
                  ),
                  45.hSpace,

                  DSFormfield(
                    validateFunction: Validators.name(),
                    controller: _firstNamecontroller,
                    hintText: Strings.firstName,
                    prefixIcon: const Icon(Icons.person),
                  ),
                  DSFormfield(
                    validateFunction: Validators.name(),
                    controller: _lastNamecontroller,
                    hintText: Strings.lastName,
                    prefixIcon: const Icon(Icons.person),
                  ),
                  DSFormfield(
                    controller: _usernamecontroller,
                    hintText: 'Username',
                    prefixIcon: const Icon(Icons.person),
                  ),
                  DSEmailField(
                    validateFunction: Validators.email(),
                    controller: _emailAddressController,
                    hintText: Strings.emailAddress,
                    prefixIcon: const Icon(Icons.email),
                  ),
                  DSFormfield(
                    validateFunction: Validators.phone(),
                    controller: _phoneNumbercontroller,
                    hintText: Strings.phoneNumber,
                    keyboardType: TextInputType.number,
                    maxLength: 11,
                    prefixIcon: const Icon(
                      Icons.phone,
                    ),
                  ),

                  DSPasswordField(
                    validateFunction: Validators.password(),
                    controller: _passwordController,
                    hintText: Strings.password,
                    showError: false,
                    padding: 8.hSpace,
                  ),
                  // PasswordValidatorWidget(password: _passwordController.text),
                  11.hSpace,
                  DSPasswordField(
                    validateFunction: (val) => Validators.confirmPass(
                      val,
                      _passwordController.text,
                    ),
                    controller: _confirmPasswordController,
                    hintText: 'Confirm Password',
                    showError: false,
                    padding: 8.hSpace,
                  ),

                  11.hSpace,

                  const SizedBox(
                    height: 31,
                  ),
                  Consumer(
                    builder: (context, r, c) {
                      final isLoading = r.watch(
                        registerNotifier
                            .select((v) => v.registerState.isLoading),
                      );
                      return MapsDataSendButton(
                        isEnabled: r.watch(
                              registerNotifier.select((v) => v.inputValid),
                            ) &&
                            !isLoading,
                        isLoading: isLoading,
                        onTap: () {
                          // context.replaceNamed(Dashboard.routeName);
                          _signUp();
                        },
                        title: Strings.register,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 31,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: 'Already have an account ',
                            style: context.textTheme.s12w400
                                .copyWith(color: AppColors.primary1D1446),
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.pushNamed(Login.routeName);
                                  },
                                text: Strings.login,
                                style: context.textTheme.s12w700
                                    .copyWith(color: AppColors.primaryColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
