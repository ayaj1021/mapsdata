import 'package:flutter/material.dart';
import 'package:mapsdata/presentation/general_widgets/custom_app_dropdown.dart';

// ignore: must_be_immutable
class DiscoPlanWidget extends StatefulWidget {
  DiscoPlanWidget({
    super.key,
    required this.filteredPlans,
    required this.onPlanSelected,
    required this.selectedPlan,
  });
  final List<String> filteredPlans;
  String? selectedPlan;

  final Function(String) onPlanSelected;

  @override
  State<DiscoPlanWidget> createState() => _DiscoPlanWidgetState();
}

class _DiscoPlanWidgetState extends State<DiscoPlanWidget> {
  @override
  Widget build(BuildContext context) {
    final plans = widget.filteredPlans;

    return CustomDropdown(
      value: widget.selectedPlan,
      hintText: 'Select Plan',
      items: plans
          .map(
            (plan) => DropdownMenuItem(
              value: plan,
              child: Text(plan),
            ),
          )
          .toList(),
      onChanged: (value) {
        //   if (value != null) {
        // final selectedPlan = widget.filteredPlans.firstWhere(
        //   (plan) => plan == value,
        //   orElse: () => throw Exception('Plan not found'),
        // );

        setState(() {
          widget.selectedPlan = value.toString();
          // widget.selectedDataId = selectedPlan.id.toString();
          // widget.selectedPlanPrice = selectedPlan.amount.toString();
        });

        widget.onPlanSelected(value.toString());

        // }
      },
    );
  }
}
