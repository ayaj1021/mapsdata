import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';

class OnboardingWidget extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final int selectedPage;

  const OnboardingWidget({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.selectedPage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
           height: 300.h,
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),
        //const SizedBox(height: 30),
        Container(
          width: 60,
          height: 20,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFFF2F2F2)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedPage == 0
                        ? AppColors.primaryColor
                        : Colors.grey),
              ),
              Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedPage == 1
                        ? AppColors.primaryColor
                        : Colors.grey),
              ),
              Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedPage == 2
                        ? AppColors.primaryColor
                        : Colors.grey),
              ),
            ],
          ),
        ),
        const VerticalSpacing(40),
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
        ),
        const VerticalSpacing( 15),
        Text(
          description,
          textAlign: TextAlign.center,
          maxLines: 2,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
