
import 'package:flutter/material.dart';
import 'package:mapsdata/core/extensions/string_extensions.dart';
import 'package:mapsdata/core/extensions/text_theme_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/core/utils/naira_input_formatter.dart';

class DSAmountField extends StatefulWidget {
  const DSAmountField({
    required this.minAmount,
    required this.maxAmount,
    required this.walletBalance,
    super.key,
    this.controller,
    this.onChanged,
    this.readOnly = false,
  });
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final bool readOnly;
  final num minAmount;
  final num maxAmount;
  final num walletBalance;

  @override
  State<DSAmountField> createState() => _DSAmountFieldState();
}

class _DSAmountFieldState extends State<DSAmountField> {
  String? error;
  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(() {
      if (widget.controller != null && widget.controller!.text.isNotEmpty) {
        final amount = double.tryParse(
          widget.controller!.text.removeSpecialCharacters() as String,
        );
        if (amount == null) {
          setState(() {
            error = 'Invalid amount';
          });
          return;
        }
        if (amount < widget.minAmount || amount > widget.maxAmount) {
          setState(() {
            error =
                '''Amount must be between ₦${widget.minAmount} and ₦${widget.maxAmount}''';
          });
          return;
        }
        if (widget.walletBalance < amount) {
          setState(() {
            error = 'Insufficient balance';
          });
          return;
        }
        setState(() {
          error = null;
        });
      } else {
        setState(() {
          error = null;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 19),
      decoration: BoxDecoration(
        color: AppColors.greyF9F9F9,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            widget.readOnly ? 'Amount' : 'Enter Amount',
            style: context.textTheme.s12w400.copyWith(
              color: AppColors.primaryA29FB3,
            ),
          ),
          Column(
            children: [
              TextField(
                readOnly: widget.readOnly,
                textAlign: TextAlign.center,
                onChanged: widget.onChanged,
                controller: widget.controller,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  // FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  NairaInputFormatter(),
                ],
                style: context.textTheme.s18w600.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
                decoration: InputDecoration(
                  filled: false,
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  hintText: '₦0.00',
                  hintStyle: context.textTheme.s18w600.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              if (error != null)
                Text(
                  'Invalid amount',
                  textAlign: TextAlign.center,
                  style: context.textTheme.s12w400.copyWith(
                    color: AppColors.red,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
