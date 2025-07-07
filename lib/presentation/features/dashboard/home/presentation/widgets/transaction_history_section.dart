import 'package:flutter/material.dart';
import 'package:mapsdata/core/extensions/text_theme_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/core/utils/strings.dart';
import 'package:mapsdata/presentation/features/dashboard/history/presentation/view/history.dart';
import 'package:mapsdata/presentation/features/transactions/data/model/get_transactions_response.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';

class TransactionHistorySection extends StatelessWidget {
  const TransactionHistorySection({super.key, required this.transactionList});
  final List<TransactionData> transactionList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Strings.recentTransactions,
              style: context.textTheme.s16w500
                  .copyWith(color: AppColors.primaryColor),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TransactionHistory(),
                  ),
                );
              },
              child: Text(
                Strings.seeAll,
                style: context.textTheme.s12w500
                    .copyWith(color: AppColors.secondaryColor),
              ),
            ),
          ],
        ),
        const VerticalSpacing(5),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.white,
          ),
          child: Column(
            children: List.generate(
                transactionList.length < 3 ? transactionList.length : 3,
                (index) {
              final tx = transactionList[index];
              return ListTile(
                leading: Icon(
                  tx.type == "Credit"
                      ? Icons.arrow_downward
                      : Icons.arrow_upward,
                  color: tx.type == "Credit" ? Colors.green : Colors.red,
                ),
                title: Text(tx.description ?? 'No description'),
                subtitle: Text(tx.date ?? ''),
                trailing: Text("₦${tx.amount ?? '0'}"),
              );
            }),
          ),
        )
      ],
    );
  }
}
