import 'package:flutter/material.dart';
import 'package:mapsdata/presentation/features/result_checker/data/model/get_all_exams_model.dart';
import 'package:mapsdata/presentation/general_widgets/custom_app_dropdown.dart';

// ignore: must_be_immutable
class ResultCheckerNetworkSelection extends StatefulWidget {
  ResultCheckerNetworkSelection({
    super.key,
    required this.examPlans,
    required this.selectedNetwork,
    required this.onNetworkSelected,
    required this.onNidSelected,
    required this.onAmountSelected,
    required this.selectedNid,
    required this.selectedAmount,
  });

  final List<Exam> examPlans;
  String? selectedNetwork;
  String? selectedNid;
  String? selectedAmount;
  final Function(String) onNetworkSelected;
  final Function(String) onNidSelected;
  final Function(String) onAmountSelected;
  @override
  State<ResultCheckerNetworkSelection> createState() =>
      _ResultCheckerNetworkSelectionState();
}

class _ResultCheckerNetworkSelectionState
    extends State<ResultCheckerNetworkSelection> {
  @override
  Widget build(BuildContext context) {
    final plans = widget.examPlans.map((plan) => plan.exam).toSet();
    return CustomDropdown(
      value: widget.selectedNetwork,
      hintText: 'Select service provider',
      items: plans
          .map(
            (plan) => DropdownMenuItem(
              value: plan,
              child: Text(plan ?? ''),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value == null) return;

        try {
          setState(() {
            widget.selectedNetwork = value;

            final selectedPlan = widget.examPlans.firstWhere(
              (network) => network.exam == value,
              orElse: () => Exam(id: '', exam: '', amount: 0),
            );

            widget.selectedNid = selectedPlan.id;
            widget.selectedAmount = selectedPlan.amount.toString();
          });

          widget.onNetworkSelected(value);
          widget.onNidSelected(widget.selectedNid ?? '');
          widget.onAmountSelected(widget.selectedAmount ?? '0');
        } catch (e) {
          debugPrint('Error selecting exam plan: $e');
          // Optionally show an error to the user
        }
      },
      // onChanged: (value) {
      //   setState(() {
      //     widget.selectedNetwork = value!;

      //     widget.selectedNid = widget.examPlans
      //         .firstWhere((network) => network.exam == value)
      //         .id;

      //     widget.selectedAmount = widget.examPlans
      //         .firstWhere(
      //             (network) => network.amount.toString() == widget.selectedNid)
      //         .amount
      //         .toString();
      //   });
      //   widget.onNetworkSelected(value!);
      //   widget.onNidSelected(widget.selectedNid.toString());
      //   widget.onAmountSelected(widget.selectedAmount.toString());
      // },
    );
  }
}
