import 'package:flutter/material.dart';
import 'package:mapsdata/presentation/features/data_topup/data/model/get_data_response_model.dart';
import 'package:mapsdata/presentation/general_widgets/custom_app_dropdown.dart';

// ignore: must_be_immutable
class DataTypeWidget extends StatefulWidget {
  DataTypeWidget(
      {super.key,
      required this.dataPlans,
      required this.ontypeSelected,
      required this.selectedType,
      required this.selectedNetwork});

  final List<Plan> dataPlans;
  String? selectedType;
  String? selectedNetwork;
  final Function(String) ontypeSelected;
  @override
  State<DataTypeWidget> createState() => _DataTypeWidgetState();
}

class _DataTypeWidgetState extends State<DataTypeWidget> {
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
