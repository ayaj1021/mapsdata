import 'package:flutter/material.dart';
import 'package:mapsdata/core/extensions/text_theme_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';

class WalletBalanceSection extends StatelessWidget {
  const WalletBalanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.primaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      Text(
                        'Wallet balance',
                        style: context.textTheme.s12w400
                            .copyWith(color: AppColors.white),
                      ),
                      const HorizontalSpacing(5),
                      const Icon(
                        Icons.visibility_off,
                        color: AppColors.white,
                        size: 14,
                      )
                    ],
                  ),
                ],
              ),
              const VerticalSpacing(30),
              Text(
                '₦35,000,000.00',
                style:
                    context.textTheme.s14w600.copyWith(color: AppColors.white),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Transaction history',
                style:
                    context.textTheme.s12w400.copyWith(color: AppColors.white),
              ),
              const VerticalSpacing(30),
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.white,
                  ),
                  child: Text(
                    'Fund Account',
                    style: context.textTheme.s12w600
                        .copyWith(color: AppColors.primaryColor),
                  )

                  //  MapsDataSendButton(onTap: (){}, title: 'Fund Account'),

                  )
            ],
          ),
        ],
      ),
    );
  }
}
