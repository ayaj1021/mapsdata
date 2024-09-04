
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapsdata/core/extensions/text_theme_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';

class DSFormfield extends StatefulWidget {
  const DSFormfield({
    super.key,
    this.textStyle,
    this.width,
    this.labelSpace = 3,
    this.textCapitalization = TextCapitalization.sentences,
    this.padding = const SizedBox(height: 24),
    this.onTap,
    this.decoration,
    this.hintStyle,
    this.backgroundColor,
    this.isLoading = false,
    this.readOnly = false,
    this.customLabel,
    this.hintText,
    this.controller,
    this.minLines = 1,
    this.obscureText = false,
    this.enabled = true,
    this.validateFunction,
    this.borderSide = BorderSide.none,
    this.onSaved,
    this.onChange,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.nextFocusNode,
    this.submitAction,
    this.enableErrorMessage = true,
    this.maxLines = 1,
    this.maxLength,
    this.onFieldSubmitted,
    this.suffixIcon,
    this.prefixIcon,
    this.bordercolor,
    this.autofocus,
    this.label,
    this.inputFormatters,
    this.borderRadius = 5,
    this.initialValue,
    this.labelSize,
    this.labelColor,
    this.errorMessage,
    this.bottomLabel,
    this.prefix,
  });
  final double? width;
  final double? labelSize;
  final String? hintText;
  final TextEditingController? controller;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final bool? obscureText;
  final bool? enabled;
  final FormFieldValidator<String>? validateFunction;
  final void Function(String)? onSaved;
  final void Function(String)? onChange;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final VoidCallback? submitAction;
  final bool? enableErrorMessage;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onTap;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? bordercolor;
  final Color? backgroundColor;
  final Color? labelColor;
  final bool? autofocus;
  final String? label;
  final InputDecoration? decoration;
  final List<TextInputFormatter>? inputFormatters;
  final bool isLoading;
  final bool readOnly;
  final double borderRadius;
  final double labelSpace;
  final String? initialValue;
  final Widget? customLabel;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final BorderSide borderSide;
  final Widget padding;
  final TextCapitalization textCapitalization;
  final String? errorMessage;
  final Widget? bottomLabel;
  final Widget? prefix;

  @override
  State<DSFormfield> createState() => _DSFormfieldState();
}

class _DSFormfieldState extends State<DSFormfield> {
  String? error;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null)
          Text(
            widget.label!,
            style:
                context.textTheme.s12w700.copyWith(color: AppColors.primary1D1446),
          ),
        if (widget.label != null)
          SizedBox(height: widget.labelSpace),
        TextFormField(
          key: widget.key,
          textCapitalization: widget.textCapitalization,
          onTap: widget.onTap,
          readOnly: widget.readOnly,
          initialValue: widget.initialValue,
          textAlign: TextAlign.left,
          inputFormatters: widget.inputFormatters,
          autofocus: widget.autofocus ?? false,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          enabled: widget.enabled,
          validator: widget.validateFunction,
          onSaved: (val) {
            error = widget.validateFunction!(val);
            setState(() {});
            widget.onSaved?.call(val!);
          },
          onChanged: (val) {
            widget.validateFunction != null
                ? error = widget.validateFunction!(val)
                : error = null;
            setState(() {});
            if (widget.onChange != null) widget.onChange!.call(val);
          },
          style: widget.textStyle ??
              TextStyle(
                color: AppColors.primaryColor,
                fontSize: 14.sp,
              ),
          cursorColor: AppColors.primarysWatch,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          controller: widget.controller,
          obscureText: widget.obscureText!,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          focusNode: widget.focusNode,
          onFieldSubmitted: widget.onFieldSubmitted,
          decoration: widget.decoration ??
              InputDecoration(
                fillColor: widget.backgroundColor,
                prefixIcon: widget.prefixIcon,
                counterText: '',
                prefix: widget.prefix,
                suffixIcon: widget.suffixIcon,
                enabled: false,
                hintText: widget.hintText,
                hintStyle: widget.hintStyle,
              ),
        ),
        Stack(
          children: [
            if (error != null || widget.errorMessage != null) ...[
             const VerticalSpacing(5),
              Text(
                widget.errorMessage ?? error!,
                style: const TextStyle(
                  color: AppColors.red,
                  fontSize: 12,
                ),
              ),
            ],
          ],
        ),
        widget.padding,
      ],
    );
  }
}
