import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/extensions/overlay_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/core/utils/page_loader.dart';
import 'package:mapsdata/core/utils/validators.dart';
import 'package:mapsdata/presentation/features/airtime_topup/presentation/widgets/airtime_topup_header_section.dart';
import 'package:mapsdata/presentation/features/electricity/data/model/buy_electricity_request.dart';
import 'package:mapsdata/presentation/features/electricity/data/model/get_discos_response.dart';
import 'package:mapsdata/presentation/features/electricity/data/model/validate_card_number_request.dart';
import 'package:mapsdata/presentation/features/electricity/presentation/notifier/buy_electricity_notifier.dart';
import 'package:mapsdata/presentation/features/electricity/presentation/notifier/get_discos_notifier.dart';
import 'package:mapsdata/presentation/features/electricity/presentation/notifier/validate_card_number_notifier.dart';
import 'package:mapsdata/presentation/features/electricity/presentation/widgets/disco_network_dropdown.dart';
import 'package:mapsdata/presentation/features/electricity/presentation/widgets/disco_plan_dropdown.dart';
import 'package:mapsdata/presentation/features/notification/notifier/get_notification_notifier.dart';
import 'package:mapsdata/presentation/general_widgets/app_button.dart';
import 'package:mapsdata/presentation/general_widgets/digit_send_form_field.dart';
import 'package:mapsdata/presentation/general_widgets/ds_bottom_sheet.dart';
import 'package:mapsdata/presentation/general_widgets/input_pin_bottomsheet.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';

class BuyElectricityScreen extends ConsumerStatefulWidget {
  const BuyElectricityScreen({super.key});
  static const routeName = '/buyElectricity';

  @override
  ConsumerState<BuyElectricityScreen> createState() => _BuyCableScreenState();
}

class _BuyCableScreenState extends ConsumerState<BuyElectricityScreen> {
  final ValueNotifier<bool> _isEnabled = ValueNotifier(false);
  late TextEditingController _meterNumberController;
  late TextEditingController _amountController;
  late TextEditingController _phoneNumberController;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(getDiscosNotifierProvider.notifier).getDiscos();
    });
    _meterNumberController = TextEditingController()..addListener(_listener);
    _amountController = TextEditingController()..addListener(_listener);
    _phoneNumberController = TextEditingController()..addListener(_listener);
  }

  List<String> filteredPlans = ['PREPAID', 'POSTPAID'];

  num totalAmount = 1;

  void _listener() {
    _isEnabled.value = _selectedNetwork != null &&
        _selectedPlan != null &&
        _meterNumberController.text.isNotEmpty &&
        _amountController.text.isNotEmpty &&
        _phoneNumberController.text.isNotEmpty;
  }

  void _onDataProviderSelected(
    String selectedNetworkProvider,
    List<Bill> allPlans,
  ) {
    setState(() {
      _selectedNetwork = selectedNetworkProvider;

      _selectedPlan = null; // Reset plan when network changes
      _selectedPlanPrice = null; // Reset price when network changes
    });
  }

  void _onPlanSelected(String selectedNetwork) {
    setState(() {
      _selectedPlan = selectedNetwork;
      _selectedPlanPrice = null;
      totalAmount = 1;
      _meterNumberController.text = '';
    });
  }

  void _onNidSelected(String selectedNid) {
    setState(() {
      _selectedNid = selectedNid;
    });
  }

  final _pinController = TextEditingController();

  String? selectedPlanType;
  int? selectedLogoIndex;
  String? _selectedNetwork;

  String? _selectedPlan;
  String? _selectedPlanPrice;

  String? _selectedNid;

  bool isEnabled() {
    if (_selectedNetwork != null &&
        _meterNumberController.text.isNotEmpty &&
        _phoneNumberController.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _pinController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(buyElectricityNotifierProvider
        .select((state) => state.state.isLoading));
    final dataPlans = ref.watch(
        getDiscosNotifierProvider.select((v) => v.data?.bills?.toList() ?? []));
    final isDataPlansLoading =
        ref.watch(getDiscosNotifierProvider.select((v) => v.state.isLoading));

    final dataPlanNetworks = ref.watch(
        getDiscosNotifierProvider.select((v) => v.data?.bills?.toList() ?? []));

    final userData =
        ref.watch(getNotificationNotifer.select((v) => v.data?.user));
    final userBalance = userData?.wallet ?? 0;
    final cardNumber = ref
        .watch(validateCardNumberNotifierProvider.select((v) => v.data?.name));

    final isCardNumberLoading = ref.watch(
        validateCardNumberNotifierProvider.select((v) => v.state.isLoading));

    return Scaffold(
      body: PageLoader(
        isLoading: isDataPlansLoading,
        child: PageLoader(
          isLoading: isLoading,
          child: SafeArea(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const CustomAppHeaderSection(
                    title: 'Buy Cable',
                  ),
                  const VerticalSpacing(30),
                  DiscoNetworkSelection(
                    selectedNetwork: _selectedNetwork,
                    dataPlans: dataPlanNetworks,
                    onNidSelected: _onNidSelected,
                    selectedNid: _selectedNid.toString(),
                    onNetworkSelected: (selectedCableProvider) =>
                        _onDataProviderSelected(
                      selectedCableProvider,
                      dataPlans,
                    ),
                  ),
                  if (_selectedNetwork != null)
                    Column(
                      children: [
                        const VerticalSpacing(20),
                        DiscoPlanWidget(
                          filteredPlans: filteredPlans,
                          onPlanSelected: _onPlanSelected,
                          selectedPlan: _selectedPlan,
                        ),
                        const VerticalSpacing(20),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 1),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            // color: AppColors.white,
                          ),
                          child: DSFormfield(
                            onChange: (value) {
                              if (_selectedPlanPrice != null &&
                                  value.isNotEmpty) {
                                setState(() {
                                  totalAmount =
                                      (num.tryParse(_selectedPlanPrice!) ?? 0) *
                                          (num.tryParse(value) ?? 1);
                                });
                              }

                              final data = ValidateCardNumberRequest(
                                  meterNumber:
                                      _meterNumberController.text.trim(),
                                  id: _selectedNid.toString(),
                                  type:
                                      _selectedPlan?.toUpperCase().toString() ??
                                          '');
                              if (value.isNotEmpty && value.length >= 10) {
                                ref
                                    .read(validateCardNumberNotifierProvider
                                        .notifier)
                                    .validateCardNumber(
                                        request: data,
                                        onError: (error) {
                                          context.showError(message: error);
                                        },
                                        onSuccess: (message) {
                                          context.showSuccess(message: message);
                                        });
                              }
                            },
                            label: 'Meter Number',
                            controller: _meterNumberController,
                            validateFunction: Validators.notEmpty(),
                            hintText: 'Enter meter number',
                            keyboardType: TextInputType.number,
                            maxLength: 11,
                          ),
                        ),
                        if (isCardNumberLoading)
                          Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                        if (cardNumber != null)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                width: 1.5,
                                color: AppColors.primary808080
                                    .withValues(alpha: 0.15),
                              ),
                            ),
                            child: Text(cardNumber),
                          ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: DSFormfield(
                            label: 'Amount',
                            controller: _amountController,
                            validateFunction: Validators.notEmpty(),
                            hintText: 'Enter amount',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: DSFormfield(
                            label: 'Phone number',
                            controller: _phoneNumberController,
                            validateFunction: Validators.notEmpty(),
                            hintText: 'Enter phone number',
                            keyboardType: TextInputType.phone,
                            maxLength: 11,
                          ),
                        ),
                      ],
                    ),
                  VerticalSpacing(60),
                  ValueListenableBuilder(
                      valueListenable: _isEnabled,
                      builder: (context, r, c) {
                        return MapsDataSendButton(
                          //  isLoading: isLoading,
                          isEnabled: r,
                          onTap: () {
                            userBalance < totalAmount
                                ? context.showError(
                                    message: 'Insuffienct funds')
                                : showPinBottomSheet();
                          },
                          title: 'Proceed',
                        );
                      })
                ],
              ),
            ),
          )),
        ),
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
              _buyElectricity();
            }
          },
        ));
      },
    );
  }

  void _buyElectricity() {
    final data = BuyElectricityRequest(
      id: _selectedNid.toString(),
      pin: _pinController.text.trim(),
      type: _selectedPlan?.toUpperCase().toString() ?? '',
      meterNumber: _meterNumberController.text.trim(),
      amount: _amountController.text.trim(),
      number: _phoneNumberController.text.trim(),
    );

    ref.read(buyElectricityNotifierProvider.notifier).buyElectricity(
          request: data,
          onSuccess: (message) {
            context.showSuccess(message: message);
          },
          onError: (message) {
            context.showError(message: message);
          },
        );
  }
}
