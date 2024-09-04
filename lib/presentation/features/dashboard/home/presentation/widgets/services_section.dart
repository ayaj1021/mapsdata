import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mapsdata/core/extensions/text_theme_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.white,
        ),
        child: SizedBox(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: GridView.builder(
              itemCount: services.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 3),
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(services[index]['logo']),
                        const VerticalSpacing(5),
                        Text(
                          services[index]['title'],
                          style: context.textTheme.s12w400
                              .copyWith(color: AppColors.primaryColor),
                        ),
                      ],
                    ));
              }),
        ));
  }
}

List<Map<String, dynamic>> services = [
  {'logo': 'assets/svg/data_new.svg', 'title': 'Data & Airtime'},
  {'logo': 'assets/svg/airtime_new.svg', 'title': 'Airtime to Cash'},
  {'logo': 'assets/svg/electricity_new.svg', 'title': 'Bills Payment'},
  {'logo': 'assets/svg/internet_new.svg', 'title': 'Bulk Sms'},
  {'logo': 'assets/svg/education_new.svg', 'title': 'Result Checker'},
  {'logo': 'assets/svg/cable_new.svg', 'title': 'Cable subscription'},
];
