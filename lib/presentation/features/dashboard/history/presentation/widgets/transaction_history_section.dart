import 'package:flutter/material.dart';
import 'package:mapsdata/presentation/features/dashboard/history/presentation/widgets/transaction_history_widget.dart';

class TransactionHistoryList extends StatelessWidget {
  const TransactionHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TransactionHistoryWidget(),
        TransactionHistoryWidget(),
        TransactionHistoryWidget(),
        TransactionHistoryWidget(),
        TransactionHistoryWidget(),
        TransactionHistoryWidget(),
        TransactionHistoryWidget(),
        TransactionHistoryWidget(),
        TransactionHistoryWidget(),
        TransactionHistoryWidget(),
        TransactionHistoryWidget(),
      ],
    );
  }
}
