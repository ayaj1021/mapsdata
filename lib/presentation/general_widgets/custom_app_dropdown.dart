import 'package:flutter/material.dart';
import 'package:mapsdata/core/extensions/text_theme_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';

class CustomDropdown<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>>? items;
  final String hintText;
  final String? label;
  final ValueChanged<T?>? onChanged;
  final double borderRadius;
  final double borderWidth;
  final bool isRequired;

  const CustomDropdown({
    super.key,
    this.value,
    this.items,
    this.hintText = 'Select',
    this.onChanged,
    this.borderRadius = 8.0,
    this.borderWidth = 1.5,
    this.label,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Row(
            children: [
              Text(
                label!,
                style: context.textTheme.s15w600.copyWith(
                    // color: AppColors.primaryColor,
                    ),

                // style: AppTextStyles.bodyMedium.copyWith(fontSize: 15),
              ),
              isRequired
                  ? Text(
                      ' *',
                      style: context.textTheme.s15w500.copyWith(
                        color: AppColors.red,
                      ),
                      // style: AppTextStyles.bodyMedium.copyWith(
                      //   fontSize: 15,
                      //   color: AppColors.red,
                      // ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        if (label != null) const VerticalSpacing(8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              width: borderWidth,
              color: AppColors.primary808080.withValues(alpha: 0.15),
            ),
          ),
          child: DropdownButton<T>(
            dropdownColor: AppColors.white,
            value: value,
            elevation: 0,
            padding: EdgeInsets.zero,
            hint: Text(
              hintText,
              style: context.textTheme.s14w400.copyWith(
                color: AppColors.primary808080,
              ),
              // style: AppTextStyles.bodyMedium.copyWith(
              //   color: AppColors.primary808080,
              // ),
            ),
            underline: const SizedBox.shrink(),
            icon: const Icon(Icons.keyboard_arrow_down),
            isExpanded: true, // Fixed typo here
            items: items,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
