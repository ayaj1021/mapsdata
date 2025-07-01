import 'package:flutter/material.dart';
import 'package:mapsdata/presentation/features/data_card/data/model/get_data_cards_response.dart';
import 'package:mapsdata/presentation/general_widgets/custom_app_dropdown.dart';

// ignore: must_be_immutable
class DataCardPlansWidget extends StatefulWidget {
  DataCardPlansWidget(
      {super.key,
      required this.dataPlans,
      required this.ontypeSelected,
      required this.selectedType,
      required this.selectedNetwork});

  final List<DataCardsPlan> dataPlans;
  String? selectedType;
  String? selectedNetwork;
  final Function(String) ontypeSelected;
  @override
  State<DataCardPlansWidget> createState() => _DataCardPlansWidgetState();
}

class _DataCardPlansWidgetState extends State<DataCardPlansWidget> {
  @override
  Widget build(BuildContext context) {
    final plans = widget.dataPlans
        .where((e) => e.network == widget.selectedNetwork)
        .toList();

    final uniqueTypes = plans.map((plan) => plan.type).toSet().toList();

    return CustomDropdown(
      value: widget.selectedType,
      hintText: 'Data Type',
      items: uniqueTypes
          .map(
            (plan) => DropdownMenuItem(
              value: plan,
              child: Text(plan ?? ''),
            ),
          )
          .toList(),
      onChanged: (value) {
        setState(() {
          widget.selectedType = value.toString();
        });
        widget.ontypeSelected(value.toString());
      },
    );
  }
}
