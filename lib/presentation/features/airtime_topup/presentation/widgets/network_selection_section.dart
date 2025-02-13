import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mapsdata/core/theme/app_colors.dart';

// ignore: must_be_immutable
class NetworkSelectionSection extends StatefulWidget {
  NetworkSelectionSection({super.key, required this.selectedLogoIndex});

  int? selectedLogoIndex;
  @override
  State<NetworkSelectionSection> createState() =>
      _NetworkSelectionSectionState();
}

class _NetworkSelectionSectionState extends State<NetworkSelectionSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white,
      ),
      child: 
      
      
      Row(
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
                    log(widget.selectedLogoIndex.toString());
                   // log(index.toString());
                    setState(() {
                      widget.selectedLogoIndex = index;
                    });
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.selectedLogoIndex == index
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
