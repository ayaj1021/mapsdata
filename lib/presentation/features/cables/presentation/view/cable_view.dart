import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/extensions/overlay_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/core/utils/page_loader.dart';
import 'package:mapsdata/core/utils/validators.dart';
import 'package:mapsdata/presentation/features/airtime_topup/presentation/widgets/airtime_topup_header_section.dart';
import 'package:mapsdata/presentation/features/cables/data/model/buy_cable_request.dart';
import 'package:mapsdata/presentation/features/cables/data/model/get_cable_plans_model.dart';
import 'package:mapsdata/presentation/features/cables/data/model/validate_cable_number_request.dart';
import 'package:mapsdata/presentation/features/cables/presentation/notifier/buy_cable_notifier.dart';
import 'package:mapsdata/presentation/features/cables/presentation/notifier/get_cable_plans_notifier.dart';
import 'package:mapsdata/presentation/features/cables/presentation/notifier/validate_cable_number_notifier.dart';
import 'package:mapsdata/presentation/features/cables/presentation/widgets/cable_newwork_drop_down.dart';
import 'package:mapsdata/presentation/features/cables/presentation/widgets/cable_plans_widget.dart';
import 'package:mapsdata/presentation/features/notification/notifier/get_notification_notifier.dart';
import 'package:mapsdata/presentation/features/set_pin/data/model/set_pin_request.dart';
import 'package:mapsdata/presentation/features/set_pin/presentation/notifier/set_pin_notifier.dart';
import 'package:mapsdata/presentation/features/set_pin/presentation/view/set_pin_message.dart';
import 'package:mapsdata/presentation/general_widgets/app_button.dart';
import 'package:mapsdata/presentation/general_widgets/digit_send_form_field.dart';
import 'package:mapsdata/presentation/general_widgets/ds_bottom_sheet.dart';
import 'package:mapsdata/presentation/general_widgets/input_pin_bottomsheet.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';

class BuyCableScreen extends ConsumerStatefulWidget {
  const BuyCableScreen({super.key});
  static const routeName = '/buyCable';

  @override
  ConsumerState<BuyCableScreen> createState() => _BuyCableScreenState();
}

class _BuyCableScreenState extends ConsumerState<BuyCableScreen> {
  final ValueNotifier<bool> _isEnabled = ValueNotifier(false);
  late TextEditingController _cardNumberController;
  late TextEditingController _phoneNumberController;
  final _setPinController = TextEditingController();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final isLoading =
          ref.watch(setPinNotifer.select((v) => v.state.isLoading));
      await ref.read(getCablePlansNotifierProvider.notifier).getCablePlans(
        onSuccess: (message, hasPin) {
          if (mounted) {
            hasPin
                ? null
                : setPinNotificationAlert(
                    context,
                    _setPinController,
                    onTap: () {
                      if (_setPinController.text.isEmpty) {
                        context.showError(message: 'Enter pin');
                      } else {
                        setPin();
                      }
                    },
                    isLoading: isLoading,
                  );
          }
        },
      );
    });
    _cardNumberController = TextEditingController()..addListener(_listener);
    _phoneNumberController = TextEditingController()..addListener(_listener);
  }

  void setPin() {
    final data = SetPinRequest(pin: _setPinController.text.trim());
    ref.read(setPinNotifer.notifier).setPin(
        data: data,
        onSuccess: (message) {
          context.showSuccess(message: message);
          Navigator.pop(context);
        },
        onError: (error) {
          context.showError(message: error);
        });
  }

  List<Plan> filteredPlans = [];

  num totalAmount = 1;

  void _listener() {
    _isEnabled.value = _selectedNetwork != null &&
        _selectedPlan != null &&
        _cardNumberController.text.isNotEmpty &&
        _phoneNumberController.text.isNotEmpty;
  }

  void _onDataProviderSelected(
    String selectedNetworkProvider,
    List<Plan> allPlans,
  ) {
    setState(() {
      _selectedNetwork = selectedNetworkProvider;

      _selectedPlan = null; // Reset plan when network changes
      _selectedPlanPrice = null; // Reset price when network changes
      _updateFilteredPlans(
          allPlans); // Update filtered plans based on the new network
    });
  }

  void _updateFilteredPlans(List<Plan> allPlans) {
    filteredPlans = allPlans.where((plan) {
      final matchesNetwork = _selectedNetwork == null ||
          plan.cable?.trim().toLowerCase() ==
              _selectedNetwork!.trim().toLowerCase();
      return matchesNetwork;
    }).toList();
  }

  void _onPlanSelected(String selectedNetwork) {
    setState(() {
      _selectedPlan = selectedNetwork;
      _selectedPlanPrice = null;
      totalAmount = 1;
      _cardNumberController.text = '';
    });
  }

  void _onPlanPriceSelected(String selectedPlanPrice) {
    setState(() {
      _selectedPlanPrice = selectedPlanPrice;
    });
  }

  void _onDataIdSelected(String selectedDataId) {
    setState(() {
      _selectedDataId = selectedDataId;
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
  String? selected;
  String? _selectedType;
  String? _selectedPlan;
  String? _selectedPlanPrice;

  String? _selectedNid;
  String? _selectedDataId;
  bool isEnabled() {
    if (_selectedNetwork != null &&
        _cardNumberController.text.isNotEmpty &&
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
    final isLoading = ref.watch(
        buyCableNotifierProvider.select((state) => state.state.isLoading));
    final dataPlans = ref.watch(getCablePlansNotifierProvider
        .select((v) => v.data?.plans?.toList() ?? []));
    final isDataPlansLoading = ref
        .watch(getCablePlansNotifierProvider.select((v) => v.state.isLoading));

    final dataPlanNetworks = ref.watch(getCablePlansNotifierProvider
        .select((v) => v.data?.plans?.toList() ?? []));

    final userData =
        ref.watch(getNotificationNotifer.select((v) => v.data?.user));
    final userBalance = userData?.wallet ?? 0;
    final cardNumber = ref
        .watch(validateCableNumberNotifierProvider.select((v) => v.data?.name));

    final isCardNumberLoading = ref.watch(
        validateCableNumberNotifierProvider.select((v) => v.state.isLoading));

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
                  CableNetworkSelection(
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
                        CablePlanWidget(
                          filteredPlans: filteredPlans,
                          onPlanSelected: _onPlanSelected,
                          selectedPlan: _selectedPlan,
                          selectedNetwork: _selectedNetwork,
                          selectedType: _selectedType,
                          onDataIdSelected: _onDataIdSelected,
                          selectedDataId: _selectedDataId,
                          selectedPlanPrice: _selectedPlanPrice,
                          onPlanPriceSelected: _onPlanPriceSelected,
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

                              final data = ValidateCableNumberRequest(
                                cardNumber: _cardNumberController.text.trim(),
                                id: _selectedNid.toString(),
                              );
                              if (value.isNotEmpty && value.length >= 10) {
                                ref
                                    .read(validateCableNumberNotifierProvider
                                        .notifier)
                                    .validateCableNumber(
                                        request: data,
                                        onError: (error) {
                                          context.showError(message: error);
                                        },
                                        onSuccess: (message) {
                                          context.showSuccess(message: message);
                                        });
                              }
                            },
                            label: 'IUC Number',
                            controller: _cardNumberController,
                            validateFunction: Validators.notEmpty(),
                            hintText: 'Enter iuc number',
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
              _buyCable();
            }
          },
        ));
      },
    );
  }

  void _buyCable() {
    final data = BuyCableRequest(
      id: _selectedDataId.toString(),
      pin: _pinController.text.trim(),
      cardNumber: _cardNumberController.text.trim(),
      number: _phoneNumberController.text.trim(),
    );

    ref.read(buyCableNotifierProvider.notifier).buyCable(
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
