import 'package:flutter/material.dart';
import 'package:mapsdata/core/extensions/text_theme_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/presentation/features/dashboard/history/presentation/view/history.dart';
import 'package:mapsdata/presentation/features/fund_account/presentation/view/fund_account_options.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';

class WalletBalanceSection extends StatelessWidget {
  const WalletBalanceSection({super.key, required this.walletBalance});
  final String walletBalance;

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
                '₦$walletBalance',
                style:
                    context.textTheme.s14w600.copyWith(color: AppColors.white),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TransactionHistory(),
                    ),
                  );
                },
                child: Text(
                  'Transaction history',
                  style: context.textTheme.s12w400
                      .copyWith(color: AppColors.white),
                ),
              ),
              const VerticalSpacing(30),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      showDragHandle: true,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topRight: Radius.circular(32),
                        topLeft: Radius.circular(32),
                      )),
                      context: context,
                      builder: (_) {
                        return const FundAccountOptions();
                      });
                },
                child: Container(
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

                    ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
