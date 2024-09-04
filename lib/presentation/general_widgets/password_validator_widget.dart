import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mapsdata/core/extensions/text_theme_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/core/utils/validators.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';

class PasswordValidatorWidget extends StatefulWidget {
  const PasswordValidatorWidget({super.key, required this.password});

  final String password;

  @override
  State<PasswordValidatorWidget> createState() =>
      _PasswordValidatorWidgetState();
}

class _PasswordValidatorWidgetState extends State<PasswordValidatorWidget> {
  late List<bool> _validationResults;
  final List<String> validationStrings = [
    'Eight Or More Characters',
    'One Or More Uppercase',
    'One Or More Lowercase',
    'One Or More Numbers',
    'One Or More Special Character',
  ];

  @override
  void initState() {
    super.initState();
    _validatePassword(widget.password);
  }

  void _validatePassword(String password) {
    final validators = [
      Validators.minLength(8),
      Validators.containsUpper(),
      Validators.containsLower(),
      Validators.containsNumber(),
      Validators.containsSpecialChar(),
    ];

    setState(() {
      _validationResults =
          validators.map((validator) => validator(password) == null).toList();
    });
  }

  @override
  void didUpdateWidget(PasswordValidatorWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.password != widget.password) {
      _validatePassword(widget.password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      for (var i = 0; i < _validationResults.length; i++)
        ValidatorText(
            isValid: _validationResults[i], text: validationStrings[i]),
    ]);
  }
}

class ValidatorText extends StatelessWidget {
  const ValidatorText({
    super.key,
    required this.isValid,
    required this.text,
  });
  final bool isValid;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/pass-check.svg',
            fit: BoxFit.scaleDown,
            colorFilter: ColorFilter.mode(
                switch (isValid) {
                  true => AppColors.green,
                  _ => AppColors.secondaryColor,
                },
                BlendMode.srcIn),
          ),
          const VerticalSpacing(8),
          Text(
            text,
            style: context.textTheme.s10w400.copyWith(
                color: switch (isValid) {
              true => AppColors.primary433C65,
              _ => AppColors.primary140E31
            }),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
