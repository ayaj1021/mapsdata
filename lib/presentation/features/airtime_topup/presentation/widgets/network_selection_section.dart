import 'package:flutter/material.dart';
import 'package:mapsdata/core/theme/app_colors.dart';

class NetworkSelectionSection extends StatefulWidget {
  const NetworkSelectionSection({super.key});

  @override
  State<NetworkSelectionSection> createState() =>
      _NetworkSelectionSectionState();
}

class _NetworkSelectionSectionState extends State<NetworkSelectionSection> {
  int? selectedLogoIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(4, (index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    // handleLogoSelection(
                    //     logos[index].toString());
                    setState(() {
                      selectedLogoIndex = index;
                    });
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selectedLogoIndex == index
                            ? AppColors.primaryColor
                            : Colors.transparent),
                    child: CircleAvatar(
                        radius: 25,
                        child: Image.asset(networkProvidersImage[index])),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

List<String> networkProvidersImage = [
  'assets/logo/mtn.png',
  'assets/logo/glo.png',
  'assets/logo/airtel.png',
  'assets/logo/9mobile.png',
];
