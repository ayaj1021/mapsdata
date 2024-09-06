import 'package:flutter/material.dart';
import 'package:mapsdata/core/extensions/text_theme_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/core/utils/strings.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';

class TransactionHistorySection extends StatelessWidget {
  const TransactionHistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Strings.recentTransactions,
              style: context.textTheme.s16w500
                  .copyWith(color: AppColors.primaryColor),
            ),
            Text(
              Strings.seeAll,
              style: context.textTheme.s12w500
                  .copyWith(color: AppColors.secondaryColor),
            ),
          ],
        ),
        const VerticalSpacing(5),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.white,
          ),
          child: Column(
            children: List.generate(3, (index) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 25,
                              backgroundColor: AppColors.primaryDEEDF7,
                              child: Icon(Icons.call_outlined),
                            ),
                            const HorizontalSpacing(10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Airtime',
                                  style: context.textTheme.s14w500.copyWith(
                                    color: AppColors.primary1A1A1A,
                                  ),
                                ),
                                Text(
                                  'Apr 18th, 20:59',
                                  style: context.textTheme.s12w400.copyWith(
                                    color: AppColors.primary475569,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '-₦35,000.00',
                              style: context.textTheme.s14w500.copyWith(
                                color: AppColors.primary1A1A1A,
                              ),
                            ),
                            Text(
                              'Successful',
                              style: context.textTheme.s12w400.copyWith(
                                color: AppColors.green,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const VerticalSpacing(10)
                  ],
                ),
              );
            }),
          ),
        )
     
     
      ],
    );
  }
}
