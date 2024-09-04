import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NairaInputFormatter extends TextInputFormatter {
  NairaInputFormatter({this.prefix = '₦'});
  final String prefix;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    newValue = FilteringTextInputFormatter.allow(RegExp('[0-9.]*'))
        .formatEditUpdate(oldValue, newValue);
    final cleanNewText = newValue.text.replaceAll(',', '');
    if (cleanNewText.isEmpty) {
      return newValue;
    }

    final parts = cleanNewText.split('.');
    final mainAmount = NumberFormat.currency(
      locale: 'en',
      decimalDigits: 0,
      symbol: prefix,
    ).format(double.tryParse(parts[0]) ?? 0);

    return TextEditingValue(
      text: mainAmount,
      selection: TextSelection.collapsed(offset: mainAmount.length),
    );
  }

  String formatText(String text) {
    return formatEditUpdate(
      TextEditingValue.empty,
      TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      ),
    ).text;
  }
}
