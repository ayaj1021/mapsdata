import 'package:flutter/material.dart';
import 'package:mapsdata/presentation/features/dashboard/home/presentation/widgets/bvn_message.dart';
import 'package:mapsdata/presentation/features/dashboard/home/presentation/widgets/home_header_section.dart';
import 'package:mapsdata/presentation/features/dashboard/home/presentation/widgets/services_section.dart';
import 'package:mapsdata/presentation/features/dashboard/home/presentation/widgets/transaction_history_section.dart';
import 'package:mapsdata/presentation/features/dashboard/home/presentation/widgets/wallet_balance_section.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bvnNotificationAlert(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              HomeHeaderSection(),
              VerticalSpacing(30),
              WalletBalanceSection(),
              VerticalSpacing(20),
              ServicesSection(),
              VerticalSpacing(15),
              TransactionHistorySection()
            ],
          ),
        ),
      )),
    );
  }
}
