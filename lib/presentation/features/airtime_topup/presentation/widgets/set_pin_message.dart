import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapsdata/core/extensions/text_theme_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/core/utils/strings.dart';
import 'package:mapsdata/presentation/general_widgets/app_button.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';
import 'package:pinput/pinput.dart';

Future<dynamic> setPinNotificationAlert(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Container(
           height: 350.h,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.white,
            ),
            child: Column(
              children: [
                Text(
                  Strings.setTransactionPin,
                  style: context.textTheme.s16w700.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
                const VerticalSpacing(12),
                Text(
                  Strings.inorderToMakeYourAccount,
                  style: context.textTheme.s14w400.copyWith(
                    color: AppColors.primarysWatch.shade400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const VerticalSpacing(20),

                const Pinput(
                  length: 4,
                  keyboardType: TextInputType.number,
                ),
                const VerticalSpacing(30),
                MapsDataSendButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    title: 'Okay')
              ],
            ),
          ),
        );
      });
}
