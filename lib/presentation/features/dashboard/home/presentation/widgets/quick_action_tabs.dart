import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mapsdata/core/extensions/text_theme_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';

class QuickActionTabs extends StatelessWidget {
  const QuickActionTabs({
    required this.image,
    required this.title,
     this.color,
    super.key,
    this.onTap,
  });
  final String image;
  final String title;
  final Color? color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 54,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(15),
            ),
            child: SvgPicture.asset(image),
          ),
          //const VerticalSpacing(4),
          Text(
            title,
            style: context.textTheme.s12w400
                .copyWith(color: AppColors.primarysWatch.shade900),
          ),
        ],
      ),
    );
  }
}
