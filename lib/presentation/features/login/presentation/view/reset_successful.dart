
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mapsdata/core/extensions/space_extension.dart';
import 'package:mapsdata/core/extensions/text_theme_extension.dart';
import 'package:mapsdata/core/utils/strings.dart';
import 'package:mapsdata/presentation/features/login/presentation/view/login.dart';
import 'package:mapsdata/presentation/general_widgets/app_button.dart';
import 'package:mapsdata/presentation/general_widgets/ds_bottom_sheet.dart';

class ResetSuccessful extends StatefulWidget {
  const ResetSuccessful({super.key});

  @override
  State<ResetSuccessful> createState() => _ResetSuccessfulState();
}

class _ResetSuccessfulState extends State<ResetSuccessful> {
  @override
  Widget build(BuildContext context) {
    return DsBottomSheet(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SvgPicture.asset(
            'assets/icons/check-mark.svg',
          ),
          27.hSpace,
          Text(
            Strings.passwordReset,
            style: context.textTheme.s16w700,
            textAlign: TextAlign.center,
          ),
          5.hSpace,
          const Text(
            Strings.passwordResetSub,
            textAlign: TextAlign.center,
          ),
          37.hSpace,
          MapsDataSendButton(
            onTap: () {
              Navigator.pushReplacementNamed(
                context,
                Login.routeName,
              );
            },
            title: Strings.login,
          ),
        ],
      ),
    );
  }
}
