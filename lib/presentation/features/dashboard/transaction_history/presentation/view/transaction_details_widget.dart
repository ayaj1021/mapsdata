import 'package:flutter/material.dart';
import 'package:mapsdata/core/extensions/text_theme_extension.dart';

class TransactionDetailWidget extends StatelessWidget {
  const TransactionDetailWidget(
      {super.key,
      required this.title,
      required this.subTitle,
      this.statusColor});
  final String title;
  final String subTitle;
  final Color? statusColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: context.textTheme.s14w500,
        ),
        Text(
          subTitle,
          style: context.textTheme.s12w400.copyWith(
            color: statusColor,
          ),
        ),
      ],
    );
  }
}
