import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/core/utils/page_loader.dart';
import 'package:mapsdata/presentation/features/airtime_topup/presentation/widgets/network_selection_section.dart';
import 'package:mapsdata/presentation/features/airtime_topup/presentation/widgets/select_phone_number_section.dart';
import 'package:mapsdata/presentation/features/data_topup/data/model/get_data_response_model.dart';
import 'package:mapsdata/presentation/features/data_topup/presentation/notifier/get_all_data_plans_notifier.dart';
import 'package:mapsdata/presentation/features/data_topup/presentation/widgets/data_topup_header_section.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';

class BuyDataScreen extends ConsumerStatefulWidget {
  const BuyDataScreen({super.key});
  static const routeName = '/buyData';

  @override
  ConsumerState<BuyDataScreen> createState() => _BuyDataScreenState();
}

class _BuyDataScreenState extends ConsumerState<BuyDataScreen> {
  List<Plan> plans = [];

  // @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) async {
  //     fetchPlans();
  //     setPinNotificationAlert(context);

  //     await ref
  //         .read(getAllDataPlansNotifierProvider.notifier)
  //         .getAllDataPlans();
  //     final allDataPlans =
  //         ref.watch(getAllDataPlansNotifierProvider).getAllDataPlans;
  //     print("Fetched plans data: ${allDataPlans.data?.plans}");

  //     // Update state with the fetched plans or an empty list if null
  //     setState(() {
  //       plans = allDataPlans.data?.plans?.toList() ?? [];
  //     });

  //     print("Updated plans list: $plans");
  //   });
  //   super.initState();
  // }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref
          .read(getAllDataPlansNotifierProvider.notifier)
          .getAllDataPlans();
    });
  }

  final _phoneNumberController = TextEditingController();
  String? selectedPlanType;
  int? selectedLogoIndex;

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(getAllDataPlansNotifierProvider
        .select((state) => state.loadState.isLoading));
    return Scaffold(
      body: PageLoader(
        isLoading: isLoading,
        child: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const DataTopupHeaderSection(),
                const VerticalSpacing(30),
                NetworkSelectionSection(
                  selectedLogoIndex: selectedLogoIndex,
                ),
                const VerticalSpacing(30),
                SelectPhoneNumberSection(
                  phoneNumberController: _phoneNumberController,
                ),
                const VerticalSpacing(20),
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
                    value: selectedPlanType,
                    hint: const Text('Select a plan type'),
                    onChanged: (newValue) {
                      setState(() {
                        selectedPlanType = newValue;
                      });
                    },
                    items: plans.map((type) {
                      return DropdownMenuItem<String>(
                        value: type.plan,
                        child: Text("${type.plan}"),
                      );
                    }).toList(),
                  ),
                ),
                // SelectDataPackage(
                //   selectedPlanType: selectedPlanType.toString(),
                //   plansData: plans,
                // )

                ElevatedButton(
                    onPressed: () {
                      log('This are plans $plans');
                    },
                    child: const Text('data'))
              ],
            ),
          ),
        )),
      ),
    );
  }
}
