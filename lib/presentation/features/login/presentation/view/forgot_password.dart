import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapsdata/core/extensions/overlay_extension.dart';
import 'package:mapsdata/core/extensions/text_theme_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/core/utils/strings.dart';
import 'package:mapsdata/presentation/features/login/data/models/forgot_password_request.dart';
import 'package:mapsdata/presentation/features/login/presentation/notifier/forgot_password_notifier.dart';
import 'package:mapsdata/presentation/general_widgets/app_button.dart';
import 'package:mapsdata/presentation/general_widgets/digit_send_email_field.dart';
import 'package:mapsdata/presentation/general_widgets/ds_app_bar.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({super.key});
  static const routeName = '/forgotpassword';

  @override
  ConsumerState<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> {
  final ValueNotifier<bool> _isLoginEnabled = ValueNotifier(false);
  late TextEditingController _emailAddressController;

  @override
  void initState() {
    _emailAddressController = TextEditingController()..addListener(_listener);

    super.initState();
  }

  void _listener() {
    _isLoginEnabled.value = _emailAddressController.text.isNotEmpty;
  }

  @override
  void dispose() {
    _isLoginEnabled.dispose();
    _emailAddressController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DsAppBar(),
      body: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 24.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.forgotPassword,
                style: context.textTheme.s24w700,
              ),
              const VerticalSpacing(22),
              Text(
                Strings.forgotPasswordSub,
                style: context.textTheme.s14w400.copyWith(
                  color: AppColors.primary433C65,
                ),
              ),
              const VerticalSpacing(37),
              DSEmailField(
                controller: _emailAddressController,
                hintText: Strings.emailAddress,
              ),
              const VerticalSpacing(150),
              ValueListenableBuilder(
                valueListenable: _isLoginEnabled,
                builder: (context, r, c) {
                  return Consumer(
                    builder: (context, re, c) {
                      final isLoading = re.watch(
                        forgotPasswordNotifer
                            .select((v) => v.forgotPasswordState.isLoading),
                      );
                      return MapsDataSendButton(
                        isLoading: isLoading,
                        isEnabled: r && !isLoading,
                        onTap: _forgotPassword,
                        title: Strings.resetPassword,
                      );
                    },
                  );
                },
              ),
              const VerticalSpacing(160),
            ],
          ),
        ),
      ),
    );
  }

  void _forgotPassword() {
    final data = ForgotPasswordRequest(
      email: _emailAddressController.text.toLowerCase().trim(),
    );
    ref.read(forgotPasswordNotifer.notifier).forgotPassword(
        data: data,
        onError: (error) {
          context.showError(message: error);
        },
        onSuccess: () {
          context.hideOverLay();
          _isLoginEnabled.value = false;
          //   showModalBottomSheet<void>(
          //     isScrollControlled: true,
          //     context: context,
          //     builder: (context) {
          //       // return EnterOtp(
          //       //   email: _emailAddressController.text,
          //       // );
          //     },
          //   );
          // },
        });
  }
}
