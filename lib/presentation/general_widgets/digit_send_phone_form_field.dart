
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/core/utils/validators.dart';

class DSPhoneFormField extends StatefulWidget {
  const DSPhoneFormField({
    super.key,
    this.textStyle,
    this.width,
    this.textCapitalization = TextCapitalization.sentences,
    this.padding = const SizedBox(height: 24),
    this.onTap,
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
    this.textInputAction,
    this.focusNode,
    this.maxLines = 1,
    this.onFieldSubmitted,
    this.suffixIcon,
    this.prefixIcon,
    this.bordercolor,
    this.autofocus,
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
  final bool? obscureText;
  final bool? enabled;
  final FormFieldValidator<String>? validateFunction;
  final void Function(String)? onSaved;
  final void Function(String)? onChange;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;

  final void Function(String)? onFieldSubmitted;
  final void Function()? onTap;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? bordercolor;
  final Color? backgroundColor;
  final Color? labelColor;
  final bool? autofocus;
  final List<TextInputFormatter>? inputFormatters;
  final bool isLoading;
  final bool readOnly;
  final double borderRadius;
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
  State<DSPhoneFormField> createState() => _DSPhoneFormFieldState();
}

class _DSPhoneFormFieldState extends State<DSPhoneFormField> {
  ValueNotifier<String?> error = ValueNotifier(null);
  final ValueNotifier<Contact?> _selectedContact = ValueNotifier(null);
  final FlutterContactPicker _contactPicker = FlutterContactPicker();

  @override
  void dispose() {
    error.dispose();
    _selectedContact.dispose();

    super.dispose();
  }

  Future<void> pickAndValidateContact() async {
    final contact = await _contactPicker.selectContact();
    if (contact != null && (contact.phoneNumbers?.isNotEmpty ?? false)) {
      var cleanPhoneNumber =
          contact.phoneNumbers?.first.replaceAll(RegExp(r'\D'), '');

      cleanPhoneNumber = cleanPhoneNumber!.startsWith('234')
          ? cleanPhoneNumber.replaceFirst('234', '0')
          : cleanPhoneNumber;

      widget.controller?.text = cleanPhoneNumber;
      error.value = (widget.validateFunction ?? Validators.phone())
          .call(cleanPhoneNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
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
          validator: widget.validateFunction ?? Validators.phone(),
          onSaved: (val) {
            error.value = widget.validateFunction != null
                ? widget.validateFunction!(val)
                : Validators.phone()(val);
            widget.onSaved?.call(val!);
          },
          onChanged: (val) {
            error.value = widget.validateFunction != null
                ? widget.validateFunction!(val)
                : Validators.phone()(val);
            if (widget.onChange != null) widget.onChange!.call(val);
          },
          style: widget.textStyle ??
              TextStyle(
                color: AppColors.primaryColor,
                fontSize: 14.sp,
              ),
          cursorColor: AppColors.primarysWatch,
          maxLines: widget.maxLines,
          controller: widget.controller,
          obscureText: widget.obscureText!,
          keyboardType: TextInputType.number,
          textInputAction: widget.textInputAction,
          focusNode: widget.focusNode,
          onFieldSubmitted: widget.onFieldSubmitted,
          decoration: InputDecoration(
            filled: true,
            fillColor: widget.backgroundColor,
            prefix: widget.prefix,
            suffixIcon: widget.suffixIcon ??
                InkWell(
                  onTap: pickAndValidateContact,
                  child: SvgPicture.asset(
                    'assets/icons/phone_book.svg',
                    fit: BoxFit.scaleDown,
                  ),
                ),
            enabled: false,
            hintText: widget.hintText,
            hintStyle: widget.hintStyle,
          ),
        ),
        ValueListenableBuilder(
          valueListenable: error,
          builder: (context, value, child) {
            return Stack(
              children: [
                if (value != null || widget.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 10),
                    child: Text(
                      widget.errorMessage ?? value ?? '',
                      style: const TextStyle(
                        color: AppColors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
        widget.padding,
      ],
    );
  }
}
