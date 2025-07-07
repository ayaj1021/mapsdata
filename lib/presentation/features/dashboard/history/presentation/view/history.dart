import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/presentation/features/dashboard/history/presentation/widgets/transaction_header.dart';
import 'package:mapsdata/presentation/features/dashboard/history/presentation/widgets/transaction_history_widget.dart';
import 'package:mapsdata/presentation/features/transactions/presentation/notifier/get_transactions_notifer.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';

class TransactionHistory extends ConsumerStatefulWidget {
  const TransactionHistory({super.key});

  @override
  ConsumerState<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends ConsumerState<TransactionHistory> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(getTransactionsNotifer.notifier).getTransactions();
    });
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        final notifier = ref.read(getTransactionsNotifer.notifier);
        if (notifier.hasMore) {
          notifier.loadMore(
            onError: (e) => debugPrint('Pagination Error: $e'),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TransactionHeader(),
              VerticalSpacing(24),
              Expanded(
                child:
                    TransactionHistoryList(scrollController: _scrollController),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
