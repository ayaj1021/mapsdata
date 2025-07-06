import 'package:flutter/material.dart';
import 'package:mapsdata/presentation/features/recharge_card_printing/data/model/get_recharge_printing_response.dart';
import 'package:mapsdata/presentation/general_widgets/custom_app_dropdown.dart';

// ignore: must_be_immutable
class RechargeCardPrintingPlanWidget extends StatefulWidget {
  RechargeCardPrintingPlanWidget(
      {super.key,
      required this.filteredPlans,
      required this.onPlanSelected,
      required this.onDataIdSelected,
      required this.selectedPlan,
      required this.selectedPlanPrice,
      required this.selectedDataId,
      this.selectedNetwork,
      this.selectedType,
      required this.onPlanPriceSelected});
  final List<RangeItem> filteredPlans;
  String? selectedPlan;
  String? selectedPlanPrice;
  final String? selectedNetwork;
  final String? selectedType;
  String? selectedDataId;

  final Function(String) onPlanSelected;
  final Function(String) onPlanPriceSelected;
  final Function(String) onDataIdSelected;
  @override
  State<RechargeCardPrintingPlanWidget> createState() =>
      _RechargeCardPrintingPlanWidgetState();
}

class _RechargeCardPrintingPlanWidgetState
    extends State<RechargeCardPrintingPlanWidget> {
  @override
  Widget build(BuildContext context) {
    // Create a map to group plans by range and keep only the first occurrence
    final Map<String?, RangeItem> uniquePlansMap = {};

    for (var plan in widget.filteredPlans) {
      final rangeKey = plan.range?.toString();
      if (rangeKey != null && !uniquePlansMap.containsKey(rangeKey)) {
        uniquePlansMap[rangeKey] = plan;
      }
    }

    final uniquePlans = uniquePlansMap.values.toList();

    return CustomDropdown(
      value: widget.selectedPlan,
      hintText: 'Select Plan',
      items: uniquePlans
          .map(
            (plan) => DropdownMenuItem(
              value: plan.range?.toString(),
              child: Text('N${plan.range ?? 0}'),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value != null) {
          final selectedPlan = widget.filteredPlans.firstWhere(
            (plan) => plan.range?.toString() == value,
            orElse: () => throw Exception('Plan not found'),
          );

          setState(() {
            widget.selectedPlan = value;
            widget.selectedDataId = selectedPlan.id.toString();
            widget.selectedPlanPrice = selectedPlan.range.toString();
          });

          widget.onPlanSelected(value);
          widget.onDataIdSelected(widget.selectedDataId!);
          widget.onPlanPriceSelected(widget.selectedPlanPrice!);
        }
      },
    );
  }
}
