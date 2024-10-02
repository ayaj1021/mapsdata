import 'package:flutter/material.dart';
import 'package:mapsdata/core/extensions/build_context_extension.dart';
import 'package:mapsdata/core/extensions/text_theme_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/core/utils/strings.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';

class DataTopupHeaderSection extends StatelessWidget {
  const DataTopupHeaderSection({super.key});

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
          Strings.dataTopUp,
          style: context.textTheme.s16w700.copyWith(
            color: AppColors.primaryColor,
          ),
        )
      ],
    );
  }
}
