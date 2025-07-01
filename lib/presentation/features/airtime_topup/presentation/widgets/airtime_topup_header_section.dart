import 'package:flutter/material.dart';
import 'package:mapsdata/core/extensions/build_context_extension.dart';
import 'package:mapsdata/core/extensions/text_theme_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';

class CustomAppHeaderSection extends StatelessWidget {
  const CustomAppHeaderSection({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => context.pop(context),
          child: const Icon(
            Icons.arrow_back_ios,
            size: 14,
          ),
        ),
        const HorizontalSpacing(100),
        Text(
          title,
          style: context.textTheme.s16w700.copyWith(
            color: AppColors.primaryColor,
          ),
        )
      ],
    );
  }
}
