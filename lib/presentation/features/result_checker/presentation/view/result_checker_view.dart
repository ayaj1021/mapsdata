import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/extensions/overlay_extension.dart';
import 'package:mapsdata/core/extensions/text_theme_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/core/utils/page_loader.dart';
import 'package:mapsdata/core/utils/validators.dart';
import 'package:mapsdata/presentation/features/airtime_topup/data/model/fetch_airtime_list_model.dart';
import 'package:mapsdata/presentation/features/airtime_topup/presentation/widgets/airtime_topup_header_section.dart';
import 'package:mapsdata/presentation/features/notification/notifier/get_notification_notifier.dart';
import 'package:mapsdata/presentation/features/result_checker/data/model/buy_exam_request.dart';
import 'package:mapsdata/presentation/features/result_checker/data/model/get_all_exams_model.dart';
import 'package:mapsdata/presentation/features/result_checker/presentation/notifier/buy_exam_notifier.dart';
import 'package:mapsdata/presentation/features/result_checker/presentation/notifier/get_exam_services_notifier.dart';
import 'package:mapsdata/presentation/features/result_checker/presentation/widgets/result_network_dropdown.dart';
import 'package:mapsdata/presentation/general_widgets/app_button.dart';
import 'package:mapsdata/presentation/general_widgets/digit_send_form_field.dart';
import 'package:mapsdata/presentation/general_widgets/ds_bottom_sheet.dart';
import 'package:mapsdata/presentation/general_widgets/input_pin_bottomsheet.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';

class ResultCheckerScreen extends ConsumerStatefulWidget {
  const ResultCheckerScreen({super.key});
  static const routeName = '/resultChecker';

  @override
  ConsumerState<ResultCheckerScreen> createState() =>
      _ResultCheckerScreenState();
}

class _ResultCheckerScreenState extends ConsumerState<ResultCheckerScreen> {
  final ValueNotifier<bool> _isBuyAirtimeEnabled = ValueNotifier(false);
  late TextEditingController _quantityController;

  String? _selectedNetwork;
  String? _selectedNid;
  String? _selectedAmount;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref
          .read(getResultServicesNotifierProvider.notifier)
          .getResultServices();
      // setPinNotificationAlert(context);
    });
    _quantityController = TextEditingController()..addListener(_listener);

    super.initState();
  }

  List<AirtimeItem> filteredPlans = [];
  void _onDataProviderSelected(
      String selectedNetworkProvider, List<Exam> allPlans) {
    setState(() {
      _selectedNetwork = selectedNetworkProvider;
    });
  }

  num totalAmount = 1;

  void _listener() {
    _isBuyAirtimeEnabled.value = _quantityController.text.isNotEmpty;
  }

  void _onNidSelected(String selectedNid) {
    setState(() {
      _selectedNid = selectedNid;
    });
  }

  void _onAmountSelected(String selectedAmount) {
    setState(() {
      _selectedAmount = selectedAmount;
      if (_quantityController.text.isNotEmpty) {
        totalAmount = (num.tryParse(selectedAmount) ?? 0) *
            (num.tryParse(_quantityController.text) ?? 1);
      }
    });
  }

  int? selectedLogoIndex;

  final _pinController = TextEditingController();
  @override
  void dispose() {
    _pinController.dispose();
    _quantityController.dispose();

    super.dispose();
  }

  bool isEnabled() {
    if (_selectedNetwork != null || _quantityController.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final examPlans = ref.watch(getResultServicesNotifierProvider
        .select((v) => v.data?.exams?.toList() ?? []));
    final isLoading = ref.watch(
      buyExamNotifierProvider.select((v) => v.state.isLoading),
    );
    final userData =
        ref.watch(getNotificationNotifer.select((v) => v.data?.user));
    final userBalance = userData?.wallet ?? 0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageLoader(
        isLoading: isLoading,
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const CustomAppHeaderSection(
                title: 'Result Checker',
              ),
              const VerticalSpacing(30),
              ResultCheckerNetworkSelection(
                selectedAmount: _selectedAmount,
                onAmountSelected: _onAmountSelected,
                selectedNetwork: _selectedNetwork,
                examPlans: examPlans,
                onNidSelected: _onNidSelected,
                selectedNid: _selectedNid.toString(),
                onNetworkSelected: (selectedCableProvider) =>
                    _onDataProviderSelected(selectedCableProvider, examPlans),
              ),
              const VerticalSpacing(10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  // color: AppColors.white,
                ),
                child: DSFormfield(
                  onChange: (value) {
                    if (_selectedAmount != null && value.isNotEmpty) {
                      setState(() {
                        totalAmount = (num.tryParse(_selectedAmount!) ?? 0) *
                            (num.tryParse(value) ?? 1);
                      });
                    }
                  },
                  label: 'Quantity',
                  controller: _quantityController,
                  validateFunction: Validators.notEmpty(),
                  hintText: 'Enter quantity',
                  keyboardType: TextInputType.number,
                  maxLength: 11,
                  // prefixIcon: const Icon(Icons.phone),
                ),
              ),
              if (_selectedNetwork != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Amount',
                      style: context.textTheme.s12w700
                          .copyWith(color: AppColors.primary1D1446),
                    ),
                    const VerticalSpacing(5),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          width: 1.5,
                          color:
                              AppColors.primary808080.withValues(alpha: 0.15),
                        ),
                      ),
                      child: Text('N$totalAmount'),
                    ),
                  ],
                ),
              const VerticalSpacing(100),
              ValueListenableBuilder(
                valueListenable: _isBuyAirtimeEnabled,
                builder: (context, r, c) {
                  return MapsDataSendButton(
                    isLoading: isLoading,
                    isEnabled: isEnabled() && !isLoading,
                    onTap: () {
                      userBalance < num.parse(_quantityController.text)
                          ? context.showError(message: 'Insuffienct funds')
                          : showPinBottomSheet();
                    },
                    title: 'Proceed',
                  );
                },
              )
            ],
          ),
        )),
      ),
    );
  }

  showPinBottomSheet() {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return DsBottomSheet(
            content: InputPinBottomsheet(
          isEnabled: _pinController.text.length == 4,
          controller: _pinController,
          onTap: () {
            if (_pinController.text.length == 4) {
              _buyExam();
            }
          },
        ));
      },
    );
  }

  void _buyExam() {
    final data = BuyExamRequest(
      id: _selectedNid.toString(),
      pin: _pinController.text.trim(),
      quantity: _quantityController.text.trim(),
    );
    ref.read(buyExamNotifierProvider.notifier).buyExam(
          request: data,
          onError: (error) {
            context.showError(message: error);
          },
          onSuccess: (message) {
            context.showSuccess(message: message);
          },
        );
  }
}
