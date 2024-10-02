import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/presentation/features/airtime_topup/presentation/widgets/network_selection_section.dart';
import 'package:mapsdata/presentation/features/airtime_topup/presentation/widgets/select_phone_number_section.dart';
import 'package:mapsdata/presentation/features/airtime_topup/presentation/widgets/set_pin_message.dart';
import 'package:mapsdata/presentation/features/data_topup/data/model/get_data_response_model.dart';
import 'package:mapsdata/presentation/features/data_topup/presentation/notifier/get_all_data_plans_notifier.dart';
import 'package:mapsdata/presentation/features/data_topup/presentation/widgets/data_topup_header_section.dart';
import 'package:mapsdata/presentation/features/data_topup/presentation/widgets/select_data_package.dart';
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
    fetchPlans();
    setPinNotificationAlert(context);

    // Fetch data plans from the provider asynchronously
    await ref
        .read(getAllDataPlansNotifierProvider.notifier)
        .getAllDataPlans();

    // Using the provider to get the current state
    final allDataPlansState = ref.read(getAllDataPlansNotifierProvider);

    // Debugging: Print the fetched plans
    print("Fetched plans state: ${allDataPlansState.getAllDataPlans.data?.plans}");

    // Update the state with fetched plans or an empty list if null
    setState(() {
      plans = allDataPlansState.getAllDataPlans.data?.plans ?? [];
    });

    print("Updated plans list: $plans");
  });
}


  fetchPlans() async {
    final dataResponse = ref.watch(
        getAllDataPlansNotifierProvider.select((v) => v.getAllDataPlans));

    setState(() {
      if (dataResponse.data != null && dataResponse.data != null) {
        plans = dataResponse.data!.plans!.toSet().toList();
      } else {
        // Fallback to an empty list if data or plans are null
        //plans = [];
      }
    });
  }

  // Future<void> fetchPlans() async {

  //   setState(() {
  //     plans = ref
  //         .watch(getAllDataPlansNotifierProvider)
  //         .getAllDataPlans
  //         .data!
  //         .data!
  //         .plans!
  //         .toSet()
  //         .toList();
  //   });
  // }

  final _phoneNumberController = TextEditingController();
  String? selectedPlanType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const DataTopupHeaderSection(),
              const VerticalSpacing(30),
              const NetworkSelectionSection(),
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
    );
  }
}
