import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class DigitSendDatePicker extends StatelessWidget {
  const DigitSendDatePicker({
    required TextEditingController dobController,
    this.firstDate,
    this.lastDate,
    this.onSelect,
    super.key,
  }) : _dobController = dobController;

  final TextEditingController _dobController;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final void Function()? onSelect;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final d = await showDatePicker(
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          context: context,
          initialDate: DateTime.now(),
          firstDate: firstDate ?? DateTime(1900),
          lastDate: lastDate ?? DateTime.now(),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(),
              child: child!,
            );
          },
        );
        if (d != null) {
          onSelect?.call();
          _dobController.text = DateFormat('dd/MM/yyyy').format(d);
        }
      },
      child: SvgPicture.asset(
        'assets/icons/calendar.svg',
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
