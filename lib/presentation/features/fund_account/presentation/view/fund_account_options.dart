import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/presentation/features/fund_account/presentation/notifier/virtual_account_notifier.dart';
import 'package:mapsdata/presentation/features/fund_account/presentation/view/fund_failed_dialog.dart';
import 'package:mapsdata/presentation/features/fund_account/presentation/widgets/fund_account_options_widget.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';

class FundAccountOptions extends ConsumerWidget {
  const FundAccountOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isVirtualAccountLoading = ref
        .watch(virtualAccountNotifer.select((state) => state.state.isLoading));
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.4,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            FundAccountOptionsWidget(
              image: 'assets/logo/monnify_logo.png',
              title: isVirtualAccountLoading ? 'Loading...' : 'Monnify Funding',
              onTap: () {
                ref.read(virtualAccountNotifer.notifier).virtualAccount(
                  onSuccess: (message) {
                    // Handle success message
                  },
                  onError: (message) {
                    Navigator.pop(context);
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
                          return const FundFailedDialog();
                        });
                  },
                );
              },
            ),
            VerticalSpacing(20),
            FundAccountOptionsWidget(
              onTap: () {},
              image: 'assets/logo/wallet.png',
              title: 'Manual Funding',
            ),
            VerticalSpacing(20),
            FundAccountOptionsWidget(
              image: 'assets/logo/atm_card.png',
              title: 'ATM Funding',
            ),
          ],
        ),
      ),
    );
  }
}
