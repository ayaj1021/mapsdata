
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapsdata/core/extensions/text_theme_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/core/utils/strings.dart';
import 'package:pinput/pinput.dart';

class DigitSendOtpField extends StatefulWidget {
  const DigitSendOtpField({
    super.key,
    this.label,
    this.onChanged,
    this.errorMessage,
    this.onCompleted,
    this.length = 6,
    this.boxWidth = 72,
    this.boxHeight = 50,
    this.obscureText = true,
    this.hasError = false,
    this.readOnly = false,
    this.controller,
    this.focusNode,
    this.validator,
    this.closeKeyboardWhenCompleted = true,
    this.pinTheme,
    this.focusedPinTheme,
    this.followingPinTheme,
    this.submittedPinTheme,
    this.obscuringCharacter,
    this.mainAxisAlignment,
    this.spaceBetween,
    this.autoFocus = false,
    this.identifier,
  });
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;
  final int length;
  final double boxWidth;
  final double boxHeight;
  final String? label;
  final String? identifier;
  final String? errorMessage;
  final bool obscureText;
  final bool readOnly;
  final bool hasError;
  final DSPinTheme? pinTheme;
  final DSPinTheme? focusedPinTheme;
  final TextEditingController? controller;
  final DSPinTheme? followingPinTheme;
  final DSPinTheme? submittedPinTheme;
  final FocusNode? focusNode;
  final FormFieldValidator<String>? validator;
  final bool closeKeyboardWhenCompleted;
  final String? obscuringCharacter;
  final MainAxisAlignment? mainAxisAlignment;
  final double? spaceBetween;
  final bool autoFocus;

  @override
  State<DigitSendOtpField> createState() => _DigitSendOtpFieldState();
}

class _DigitSendOtpFieldState extends State<DigitSendOtpField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = widget.focusNode ?? FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              widget.label ?? '',
              style: Theme.of(context)
                  .textTheme
                  .s10w500
                  .copyWith(color: AppColors.primary120C2B),
            ),
          ),
        Semantics(
          identifier: widget.identifier,
          child: Pinput(
            controller: widget.controller,
            length: widget.length,
            focusNode: _focusNode,
            forceErrorState: widget.hasError,
            onCompleted: widget.onCompleted,
          //  obscureText: widget.obscureText,
            onChanged: widget.onChanged,
            autofocus: widget.autoFocus,
            obscuringWidget: Container(
              width: widget.boxWidth * .2,
              height: widget.boxHeight * .2,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColor,
              ),
            ),
            separatorBuilder: (index) =>
                SizedBox(width: widget.spaceBetween ?? 8.w),
            mainAxisAlignment:
                widget.mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
            defaultPinTheme: widget.pinTheme ?? defaultPinTheme,
            errorPinTheme: errorPinTheme,
            focusedPinTheme: widget.focusedPinTheme ?? focusedPinTheme,
            readOnly: widget.readOnly,
            followingPinTheme: widget.pinTheme ?? defaultPinTheme,
            submittedPinTheme: widget.submittedPinTheme ?? submittedPinTheme,
            closeKeyboardWhenCompleted: widget.closeKeyboardWhenCompleted,
            disabledPinTheme: widget.pinTheme ?? defaultPinTheme,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: widget.validator ??
                (text) {
                  if (text == null ||
                      text.trim().isEmpty ||
                      text.length < widget.length) {
                    return widget.errorMessage ?? Strings.invalidPin;
                  }
                  return null;
                },
          ),
        ),
        if (widget.errorMessage != null)
          Semantics(
            identifier: 'pin_error',
            child: Padding(
              padding: const EdgeInsets.only(top: 35),
              child: Text(
                widget.errorMessage ?? '',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .s14w400
                    .copyWith(color: AppColors.red, height: 22 / 10),
              ),
            ),
          ),
      ],
    );
  }

  DSPinTheme get defaultPinTheme => DSPinTheme(
        context: context,
        width: widget.boxWidth,
        height: widget.boxHeight,
      );

  DSPinTheme get errorPinTheme => DSPinTheme(
        context: context,
        color: AppColors.red.withOpacity(.1),
        width: widget.boxWidth,
        height: widget.boxHeight,
      );

  DSPinTheme get submittedPinTheme => DSPinTheme(
        context: context,
        width: widget.boxWidth,
        height: widget.boxHeight,
      );

  DSPinTheme get focusedPinTheme => DSPinTheme(
        context: context,
        width: widget.boxWidth,
        height: widget.boxHeight,
      );

  @override
  void dispose() {
    Future.microtask(() => _focusNode.dispose());
    super.dispose();
  }
}

class DSPinTheme extends PinTheme {
  DSPinTheme({
    required this.context,
    double width = 72,
    double height = 50,
    Color color = AppColors.greyFill,
  }) : super(
          width: width,
          height: height,
          textStyle: Theme.of(context).textTheme.s13w400,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: color),
            borderRadius: BorderRadius.circular(16),
          ),
        );
  final BuildContext context;
}
