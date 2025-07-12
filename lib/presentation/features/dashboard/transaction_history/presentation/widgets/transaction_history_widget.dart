import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/presentation/features/dashboard/transaction_history/presentation/view/transaction_details_view.dart';
import 'package:mapsdata/presentation/features/transactions/presentation/notifier/get_transactions_notifer.dart';

class TransactionHistoryList extends ConsumerWidget {
  final ScrollController scrollController;
  const TransactionHistoryList({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(getTransactionsNotifer);
    final stateLoading = state.state.isLoading;

    if (stateLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final dataList = state.data?.data ?? [];

    if (dataList.isEmpty) {
      return const Center(child: Text("No transactions found."));
    }

    return ListView.separated(
      controller: scrollController,
      itemCount: dataList.length + 1,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        if (index < dataList.length) {
          final tx = dataList[index];
          return ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TransactionDetailsView(
                            tx: tx,
                          )));
            },
            leading: Icon(
              tx.type == "Credit" ? Icons.arrow_downward : Icons.arrow_upward,
              color: tx.type == "Credit" ? Colors.green : Colors.red,
            ),
            title: Text(tx.description ?? 'No description'),
            subtitle: Text(tx.date ?? ''),
            trailing: Text("₦${tx.amount ?? '0'}"),
          );
        } else {
          final hasMore = ref.read(getTransactionsNotifer.notifier).hasMore;
          return hasMore
              ? const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                )
              : const SizedBox(); // Empty container if no more
        }
      },
    );
  }
}
