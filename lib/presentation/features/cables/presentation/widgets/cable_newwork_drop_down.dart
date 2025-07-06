import 'package:flutter/material.dart';
import 'package:mapsdata/presentation/features/cables/data/model/get_cable_plans_model.dart';
import 'package:mapsdata/presentation/general_widgets/custom_app_dropdown.dart';

// ignore: must_be_immutable
class CableNetworkSelection extends StatefulWidget {
  CableNetworkSelection(
      {super.key,
      required this.dataPlans,
      required this.selectedNetwork,
      required this.onNetworkSelected,
      required this.onNidSelected,
      required this.selectedNid});

  final List<Plan> dataPlans;
  String? selectedNetwork;
  String? selectedNid;
  final Function(String) onNetworkSelected;
  final Function(String) onNidSelected;
  @override
  State<CableNetworkSelection> createState() => _CableNetworkSelectionState();
}

class _CableNetworkSelectionState extends State<CableNetworkSelection> {
  @override
  Widget build(BuildContext context) {
    final plans = widget.dataPlans.map((plan) => plan.cable).toSet();
    return CustomDropdown(
      value: widget.selectedNetwork,
      hintText: 'Select Network',
      items: plans
          .map(
            (plan) => DropdownMenuItem(
              value: plan,
              child: Text(plan ?? ''),
            ),
          )
          .toList(),
      onChanged: (value) {
        setState(() {
          widget.selectedNetwork = value!;

          widget.selectedNid = widget.dataPlans
              .firstWhere((network) => network.cable == value)
              .cableId;
        });
        widget.onNetworkSelected(value!);
        widget.onNidSelected(widget.selectedNid.toString());
      },
    );
  }
}
