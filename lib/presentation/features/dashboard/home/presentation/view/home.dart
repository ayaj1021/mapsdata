import 'package:flutter/material.dart';
import 'package:mapsdata/presentation/features/dashboard/home/presentation/widgets/home_header_section.dart';
import 'package:mapsdata/presentation/features/dashboard/home/presentation/widgets/services_section.dart';
import 'package:mapsdata/presentation/features/dashboard/home/presentation/widgets/wallet_balance_section.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            HomeHeaderSection(),
            VerticalSpacing(30),
            WalletBalanceSection(),
            VerticalSpacing(30),
            ServicesSection(),
          ],
        ),
      )),
    );
  }
}