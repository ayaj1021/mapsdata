import 'package:flutter/material.dart';
import 'package:mapsdata/presentation/features/dashboard/history/presentation/widgets/transaction_header.dart';
import 'package:mapsdata/presentation/features/dashboard/history/presentation/widgets/transaction_history_section.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                TransactionHeader(),
                VerticalSpacing(24),
                TransactionHistoryList()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
