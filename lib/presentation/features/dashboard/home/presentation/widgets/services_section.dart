import 'package:flutter/material.dart';
import 'package:mapsdata/core/extensions/build_context_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/presentation/features/airtime_topup/presentation/view/airtime_topup_screen.dart';
import 'package:mapsdata/presentation/features/dashboard/home/presentation/widgets/quick_action_tabs.dart';
import 'package:mapsdata/presentation/features/data_topup/presentation/view/buy_data_screen.dart';
import 'package:mapsdata/presentation/features/maps_venture/view/maps_venture_view.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';
import 'package:url_launcher/url_launcher.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final Uri whatsapp = Uri.parse('https://wa.me/+2348160788744');
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              QuickActionTabs(
                  onTap: () => context.pushNamed(AirtimeTopupScreen.routeName),
                  image: 'assets/svg/data_new.svg',
                  title: 'Airtime Topup'),
              QuickActionTabs(
                onTap: () => context.pushNamed(BuyDataScreen.routeName),
                image: 'assets/svg/data_new.svg',
                title: 'Data Topup',
              ),
              QuickActionTabs(
                  onTap: () => context.pushNamed(MapsVenture.routeName),
                  image: 'assets/svg/data_new.svg',
                  title: 'Maps Venture'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const QuickActionTabs(
                  image: 'assets/svg/airtime_new.svg',
                  title: 'Airtime to Cash'),
              const QuickActionTabs(
                  image: 'assets/svg/electricity_new.svg',
                  title: 'Recharge card'),
              QuickActionTabs(
                  onTap: () {
                    launchUrl(whatsapp);
                  },
                  image: 'assets/svg/internet_new.svg',
                  title: 'Buy & Sell btc'),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              QuickActionTabs(
                  image: 'assets/svg/education_new.svg',
                  title: 'Result Checker'),
              HorizontalSpacing(60),
              QuickActionTabs(
                  image: 'assets/svg/cable_new.svg', title: 'Cable'),
            ],
          ),
        ],
      ),
    );
  }
}
