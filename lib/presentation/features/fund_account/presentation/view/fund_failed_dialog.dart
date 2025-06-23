import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/extensions/build_context_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/presentation/features/fund_account/presentation/view/link_nin_bvn_view.dart';
import 'package:mapsdata/presentation/general_widgets/app_button.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';

class FundFailedDialog extends ConsumerWidget {
  const FundFailedDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.45,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Icon(Icons.info, size: 50),
            ),
            SizedBox(height: 20),
            Text(
              'Kindly be aware that the Central Bank of Nigeria mandates the linkage of all virtual accounts with your BVN (Bank Verification Number). It is imperative to comply with this requirement to ensure uninterrupted use of the virtual account provided for your funding activities.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: AppColors.black),
            ),
            SizedBox(height: 20),
            MapsDataSendButton(
              isLoading: false,
              backgroundColor: AppColors.primaryColor,
              isEnabled: true,
              onTap: () {
                context.pushNamed(LinkNinBvnView.routeName);
              },
              title: 'Link Now',
            ),
            VerticalSpacing(20),
            MapsDataSendButton(
              isLoading: false,
              // Replace with actual loading state
              isEnabled: true,
              hasBorder: true,
              backgroundColor: AppColors.white,
              textColor: AppColors.primaryColor,

              onTap: () {
                // _login();
              },
              title: 'Fund wallet without linking BVN',
            ),
          ],
        ),
      ),
    );
  }
}
