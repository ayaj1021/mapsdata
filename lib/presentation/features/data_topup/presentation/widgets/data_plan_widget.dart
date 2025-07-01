import 'package:flutter/material.dart';
import 'package:mapsdata/presentation/features/data_topup/data/model/get_data_response_model.dart';
import 'package:mapsdata/presentation/general_widgets/custom_app_dropdown.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';

// ignore: must_be_immutable
class DataPlanWidget extends StatefulWidget {
  DataPlanWidget(
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
  final List<Plan> filteredPlans;
  String? selectedPlan;
  String? selectedPlanPrice;
  final String? selectedNetwork;
  final String? selectedType;
  String? selectedDataId;

  final Function(String) onPlanSelected;
  final Function(String) onPlanPriceSelected;
  final Function(String) onDataIdSelected;
  @override
  State<DataPlanWidget> createState() => _DataPlanWidgetState();
}

class _DataPlanWidgetState extends State<DataPlanWidget> {
  @override
  Widget build(BuildContext context) {
    // final plans = widget.filteredPlans.map((plan) => plan).toSet();

    final plans = widget.filteredPlans
        .where((e) => e.type == widget.selectedType)
        .toList();

    final uniquePlans = plans.map((plan) => plan).toSet().toList();
    return CustomDropdown(
      value: widget.selectedPlan,
      hintText: 'Select Plan',
      items: uniquePlans
          .map(
            (plan) => DropdownMenuItem(
              value: plan.plan,
              child: Row(
                children: [
                  Expanded(child: Text(plan.plan ?? '')),
                  HorizontalSpacing(5),
                  Expanded(child: Text('N${plan.amount.toString()}')),
                ],
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value != null) {
          final selectedPlan = widget.filteredPlans.firstWhere(
            (plan) => plan.plan == value,
            orElse: () => throw Exception('Plan not found'),
          );

          setState(() {
            widget.selectedPlan = value.toString();
            widget.selectedDataId = selectedPlan.id.toString();
            widget.selectedPlanPrice = selectedPlan.amount.toString();
          });

          widget.onPlanSelected(value.toString());
          widget.onDataIdSelected(widget.selectedDataId!);
          widget.onPlanPriceSelected(widget.selectedPlanPrice!);
        }
      },
    );
  }
}
