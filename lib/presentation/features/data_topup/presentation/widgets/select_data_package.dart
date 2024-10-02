import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapsdata/core/extensions/text_theme_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/core/utils/strings.dart';
import 'package:mapsdata/presentation/features/data_topup/data/model/get_data_response_model.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';

class SelectDataPackage extends StatefulWidget {
  SelectDataPackage({
    super.key,
    required this.selectedPlanType,
    required this.plansData,
  });
  String? selectedPlanType;

  final List<Plan> plansData;

  @override
  State<SelectDataPackage> createState() => _SelectDataPackageState();
}

class _SelectDataPackageState extends State<SelectDataPackage> {
  @override
  Widget build(BuildContext context) {
    // List<String?> planTypes =
    //     widget.plansData?.plans?.map((plan) => plan.type).toList() ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.selectDataPackage,
          style: context.textTheme.s14w500.copyWith(
            color: AppColors.primaryColor,
          ),
        ),
        const VerticalSpacing(5),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          height: 50.h,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.white,
            border: Border.all(
              color: const Color(0xffCBD5E1),
            ),
          ),
          child: DropdownButton<String>(
            underline: const SizedBox.shrink(),
            isExpanded: true,
            value: widget.selectedPlanType,
             hint: Text('Select a plan type'),
            onChanged: (newValue) {
              print('pressed');
              setState(() {
                widget.selectedPlanType = newValue;
              });
            },
            items: widget.plansData.map((type) {
              return DropdownMenuItem<String>(
                value: type.plan,
                child: Text("${type.plan}"),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
