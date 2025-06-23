import 'package:flutter/widgets.dart';
import 'package:mapsdata/core/extensions/text_theme_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';

class FundAccountOptionsWidget extends StatelessWidget {
  const FundAccountOptionsWidget(
      {super.key, required this.image, required this.title, this.onTap});
  final String image;
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.black.withValues(alpha: 0.2),
              width: 1,
            )),
        child: Row(
          children: [
            Image.asset(
              image,
              height: 24,
              width: 24,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: context.textTheme.s12w600
                  .copyWith(color: AppColors.primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
