import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapsdata/core/extensions/text_theme_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';

class HomeHeaderSection extends StatelessWidget {
  const HomeHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              height: 40.h,
              width: 40.w,
              child: Image.asset('assets/images/profile_image.png'),
            ),
            const HorizontalSpacing(7),
            Text(
              'Welcome John',
              style: context.textTheme.s18w500
                  .copyWith(color: AppColors.primaryColor),
            )
          ],
        ),
        const Icon(Icons.notifications_outlined),
      ],
    );
  }
}
