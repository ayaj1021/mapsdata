import 'package:flutter/material.dart';
import 'package:mapsdata/presentation/features/electricity/data/model/get_discos_response.dart';
import 'package:mapsdata/presentation/general_widgets/custom_app_dropdown.dart';

// ignore: must_be_immutable
class DiscoNetworkSelection extends StatefulWidget {
  DiscoNetworkSelection(
      {super.key,
      required this.dataPlans,
      required this.selectedNetwork,
      required this.onNetworkSelected,
      required this.onNidSelected,
      required this.selectedNid});

  final List<Bill> dataPlans;
  String? selectedNetwork;
  String? selectedNid;
  final Function(String) onNetworkSelected;
  final Function(String) onNidSelected;
  @override
  State<DiscoNetworkSelection> createState() => _DiscoNetworkSelectionState();
}

class _DiscoNetworkSelectionState extends State<DiscoNetworkSelection> {
  @override
  Widget build(BuildContext context) {
    final plans = widget.dataPlans.map((plan) => plan.disco).toSet();
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
              .firstWhere((network) => network.disco == value)
              .id;
        });
        widget.onNetworkSelected(value!);
        widget.onNidSelected(widget.selectedNid.toString());
      },
    );
  }
}
