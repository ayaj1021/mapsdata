import 'package:flutter/material.dart';
import 'package:mapsdata/core/extensions/text_theme_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/core/utils/strings.dart';

class ProfileHeaderSection extends StatelessWidget {
  const ProfileHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            Strings.profile,
            style: context.textTheme.s16w600.copyWith(
              color: AppColors.black,
            ),
          ),
        )
      ],
    );
  }
}
