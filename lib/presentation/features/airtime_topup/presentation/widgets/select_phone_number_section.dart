import 'package:flutter/material.dart';
import 'package:mapsdata/core/extensions/text_theme_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/core/utils/validators.dart';
import 'package:mapsdata/presentation/general_widgets/digit_send_form_field.dart';

class SelectPhoneNumberSection extends StatelessWidget {
  const SelectPhoneNumberSection(
      {super.key, required this.phoneNumberController});

  final TextEditingController phoneNumberController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.white,
          ),
          child: DSFormfield(
              label: 'Phone Number',
              controller: phoneNumberController,
              validateFunction: Validators.notEmpty(),
              hintText: 'Enter phone number',
              keyboardType: TextInputType.number,
              maxLength: 11,
              prefixIcon: const Icon(Icons.phone)

              // SvgPicture.asset(
              //   'assets/icons/person.svg',
              //   fit: BoxFit.scaleDown,
              // ),
              ),
        ),
        Positioned(
          top: 19,
          right: 0,
          child: GestureDetector(
            onTap: () async {
              // var number = await Navigator.of(context).push(
              //     MaterialPageRoute(
              //         builder: (context) => BeneficiaryScreen()));

              // if (number != null) {
              //   _phoneNumberController.text = number;
              // }
            },
            child: Text(
              'select from beneficiary',
              style: context.textTheme.s12w500.copyWith(
                color: AppColors.secondaryColor,
              ),
            ),
          ),
        )
      ],
    );
  }
}
