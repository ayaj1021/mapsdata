import 'package:flutter/material.dart';
import 'package:mapsdata/presentation/features/recharge_card_printing/data/model/get_recharge_printing_response.dart';
import 'package:mapsdata/presentation/general_widgets/custom_app_dropdown.dart';

// ignore: must_be_immutable
class RechargeCardPrintingNetworkSelection extends StatefulWidget {
  RechargeCardPrintingNetworkSelection(
      {super.key,
      required this.dataPlans,
      required this.selectedNetwork,
      required this.onNetworkSelected,
      required this.onNidSelected,
      required this.selectedNid});

  final List<RechargeItem> dataPlans;
  String? selectedNetwork;
  String? selectedNid;
  final Function(String) onNetworkSelected;
  final Function(String) onNidSelected;
  @override
  State<RechargeCardPrintingNetworkSelection> createState() =>
      _RechargeCardPrintingNetworkSelectionState();
}

class _RechargeCardPrintingNetworkSelectionState
    extends State<RechargeCardPrintingNetworkSelection> {
  @override
  Widget build(BuildContext context) {
    final plans = widget.dataPlans.map((plan) => plan.network).toSet();
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
              .firstWhere((network) => network.network == value)
              .id;
        });
        widget.onNetworkSelected(value!);
        widget.onNidSelected(widget.selectedNid.toString());
      },
    );
  }
}
