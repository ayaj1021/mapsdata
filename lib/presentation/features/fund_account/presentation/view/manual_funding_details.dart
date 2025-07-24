import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapsdata/core/extensions/build_context_extension.dart';
import 'package:mapsdata/core/extensions/overlay_extension.dart';
import 'package:mapsdata/core/extensions/text_theme_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/presentation/features/dashboard/widgets/dashboard.dart';
import 'package:mapsdata/presentation/features/fund_account/data/model/manual_funding_response.dart';
import 'package:mapsdata/presentation/general_widgets/app_button.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';

class ManualFundingDetails extends StatelessWidget {
  const ManualFundingDetails({super.key, required this.accountData});
  final AccountData accountData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 18,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Bank Details'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FundingDetailsWidget(
                      title: 'Account Name:',
                      subTitle: accountData.name ?? '',
                    ),
                    const SizedBox(height: 18),
                    FundingDetailsWidget(
                      title: 'Account Number:',
                      subTitle: accountData.number ?? '',
                      hasIcon: true,
                      onTap: () {
                        Clipboard.setData(
                          ClipboardData(text: accountData.number ?? ''),
                        );
                        context.showToast(message: 'Copied successfully');
                      },
                    ),
                    const SizedBox(height: 18),
                    FundingDetailsWidget(
                      title: 'Bank Name:',
                      subTitle: accountData.bankName ?? '',
                    ),
                  ],
                ),
              ),
              VerticalSpacing(80),
              MapsDataSendButton(
                onTap: () {
                  context.replaceAll(Dashboard.routeName);
                },
                title: 'Continue',
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FundingDetailsWidget extends StatelessWidget {
  const FundingDetailsWidget(
      {super.key,
      required this.title,
      required this.subTitle,
      this.onTap,
      this.hasIcon = false});
  final String title;
  final String subTitle;
  final bool hasIcon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: context.textTheme.s14w400,
        ),
        Row(
          children: [
            Text(
              subTitle,
              style: context.textTheme.s14w400,
            ),
            hasIcon
                ? GestureDetector(
                    onTap: onTap,
                    child: Icon(
                      Icons.copy,
                      color: AppColors.primaryColor,
                    ))
                : const SizedBox.shrink(),
          ],
        ),
      ],
    );
  }
}
