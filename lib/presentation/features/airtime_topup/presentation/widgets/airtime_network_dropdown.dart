import 'package:flutter/material.dart';
import 'package:mapsdata/presentation/features/airtime_topup/data/model/fetch_airtime_list_model.dart';
import 'package:mapsdata/presentation/general_widgets/custom_app_dropdown.dart';

// ignore: must_be_immutable
class AirtimeNetworkSelection extends StatefulWidget {
  AirtimeNetworkSelection(
      {super.key,
      required this.airtimePlans,
      required this.selectedNetwork,
      required this.onNetworkSelected,
      required this.onNidSelected,
      required this.selectedNid});

  final List<AirtimeItem> airtimePlans;
  String? selectedNetwork;
  String? selectedNid;
  final Function(String) onNetworkSelected;
  final Function(String) onNidSelected;
  @override
  State<AirtimeNetworkSelection> createState() =>
      _AirtimeNetworkSelectionState();
}

class _AirtimeNetworkSelectionState extends State<AirtimeNetworkSelection> {
  @override
  Widget build(BuildContext context) {
    final plans = widget.airtimePlans.map((plan) => plan.network).toSet();
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

          widget.selectedNid = widget.airtimePlans
              .firstWhere((network) => network.network == value)
              .id;
        });
        widget.onNetworkSelected(value!);
        widget.onNidSelected(widget.selectedNid.toString());
      },
    );
  }
}
