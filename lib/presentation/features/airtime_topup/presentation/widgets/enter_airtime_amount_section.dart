import 'package:flutter/material.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/core/utils/validators.dart';
import 'package:mapsdata/presentation/general_widgets/digit_send_form_field.dart';

class EnterAirtimeAmountSection extends StatelessWidget {
  const EnterAirtimeAmountSection({super.key, required this.amountController});
  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white,
      ),
      child: Column(
        children: [
          DSFormfield(
            label: 'Airtime amount',
            controller: amountController,
            validateFunction: Validators.notEmpty(),
            hintText: 'Enter amount',
            keyboardType: TextInputType.number,
            prefixIcon: const Icon(Icons.money),
          ),
          // if (amountController.text.isNotEmpty)
          //   Text(
          //     'You will be charged ₦${amountController.text} instead of ₦${amountController.text} 😊',
          //     style: context.textTheme.s12w500.copyWith(
          //       color: AppColors.secondaryColor,
          //     ),
          //   )
        ],
      ),
    );
  }
}
