import 'package:flutter/material.dart';
import 'package:mapsdata/core/extensions/text_theme_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/presentation/general_widgets/app_button.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';
import 'package:pinput/pinput.dart';

class InputPinBottomsheet extends StatelessWidget {
  const InputPinBottomsheet(
      {super.key,
      required this.controller,
      required this.onTap,
      required this.isEnabled});
  final TextEditingController controller;
  final void Function() onTap;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            'Enter your 4 digit pin',
            style: context.textTheme.s14w500
                .copyWith(color: AppColors.primaryColor),
          ),
        ),
        VerticalSpacing(20),
        Pinput(
          controller: controller,
          length: 4,
        ),
        VerticalSpacing(40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: MapsDataSendButton(
                backgroundColor: AppColors.greyF1F1F1,
                textColor: AppColors.primaryColor,
                isLoading: false,
                isEnabled: true,
                onTap: () {
                  Navigator.pop(context);
                },
                title: 'Cancel',
              ),
            ),
            HorizontalSpacing(20),
            Expanded(
              child: MapsDataSendButton(
                isLoading: false,
                isEnabled: isEnabled,
                onTap: onTap,
                title: 'Proceed',
              ),
            ),
          ],
        ),
        VerticalSpacing(20),
      ],
    );
  }
}
