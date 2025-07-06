import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/extensions/overlay_extension.dart';
import 'package:mapsdata/core/extensions/text_theme_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/core/utils/page_loader.dart';
import 'package:mapsdata/core/utils/validators.dart';
import 'package:mapsdata/presentation/features/airtime_topup/presentation/widgets/airtime_topup_header_section.dart';
import 'package:mapsdata/presentation/features/notification/notifier/get_notification_notifier.dart';
import 'package:mapsdata/presentation/features/recharge_card_printing/data/model/get_recharge_printing_response.dart';
import 'package:mapsdata/presentation/features/recharge_card_printing/data/model/recharge_card_printing_request.dart';
import 'package:mapsdata/presentation/features/recharge_card_printing/presentation/notifier/get_recharge_card_printing_notifier.dart';
import 'package:mapsdata/presentation/features/recharge_card_printing/presentation/notifier/recharge_card_printing_notifier.dart';
import 'package:mapsdata/presentation/features/recharge_card_printing/presentation/widgets/recharge_card_network_section.dart';
import 'package:mapsdata/presentation/features/recharge_card_printing/presentation/widgets/recharge_card_printing_plan_widget.dart';
import 'package:mapsdata/presentation/general_widgets/app_button.dart';
import 'package:mapsdata/presentation/general_widgets/digit_send_form_field.dart';
import 'package:mapsdata/presentation/general_widgets/ds_bottom_sheet.dart';
import 'package:mapsdata/presentation/general_widgets/input_pin_bottomsheet.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';

class RechargeCardPrintingScreen extends ConsumerStatefulWidget {
  const RechargeCardPrintingScreen({super.key});
  static const routeName = '/rechargeCardPrinting';

  @override
  ConsumerState<RechargeCardPrintingScreen> createState() =>
      _RechargeCardPrintingScreenState();
}

class _RechargeCardPrintingScreenState
    extends ConsumerState<RechargeCardPrintingScreen> {
  final ValueNotifier<bool> _isEnabled = ValueNotifier(false);
  late TextEditingController _quantityController;
  late TextEditingController _nameOnCardController;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref
          .read(getRechargeCardPrintingNotifierProvider.notifier)
          .getRechargeCardPrinting();
    });
    _quantityController = TextEditingController()..addListener(_listener);
    _nameOnCardController = TextEditingController()..addListener(_listener);
  }

  List<RangeItem> filteredPlans = [];

  num totalAmount = 1;

  void _listener() {
    _isEnabled.value = _quantityController.text.isNotEmpty &&
        _nameOnCardController.text.isNotEmpty;
  }

  void _onDataProviderSelected(
    String selectedNetworkProvider,
    List<RangeItem> allPlans,
  ) {
    setState(() {
      _selectedNetwork = selectedNetworkProvider;

      _selectedPlan = null; // Reset plan when network changes
      _selectedPlanPrice = null; // Reset price when network changes
      _updateFilteredPlans(
          allPlans); // Update filtered plans based on the new network
    });
  }

  void _updateFilteredPlans(List<RangeItem> allPlans) {
    filteredPlans = allPlans.where((plan) {
      final matchesNetwork = plan.id?.trim().toLowerCase() == _selectedNid;
      return matchesNetwork;
    }).toList();
  }

  void _onPlanSelected(String selectedNetwork) {
    setState(() {
      _selectedPlan = selectedNetwork;
      _selectedPlanPrice = null;
      totalAmount = 1;
      _quantityController.text = '';
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
        _quantityController.text.isNotEmpty &&
        _nameOnCardController.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _pinController.dispose();
    _nameOnCardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(rechargeCardPrintingNotifierProvider
        .select((state) => state.state.isLoading));
    final dataPlans = ref.watch(getRechargeCardPrintingNotifierProvider
        .select((v) => v.data?.range?.toList() ?? []));

    final dataPlanNetworks = ref.watch(getRechargeCardPrintingNotifierProvider
        .select((v) => v.data?.recharge?.toList() ?? []));

    final userData =
        ref.watch(getNotificationNotifer.select((v) => v.data?.user));
    final userBalance = userData?.wallet ?? 0;

    return Scaffold(
      body: PageLoader(
        isLoading: isLoading,
        child: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const CustomAppHeaderSection(
                  title: 'Recharge Card Printing',
                ),
                const VerticalSpacing(30),
                RechargeCardPrintingNetworkSelection(
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
                      RechargeCardPrintingPlanWidget(
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
                      const VerticalSpacing(10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
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
                                color: AppColors.primary808080
                                    .withValues(alpha: 0.15),
                              ),
                            ),
                            child: Text('N$totalAmount'),
                          ),
                        ],
                      ),
                      const VerticalSpacing(20),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          // color: AppColors.white,
                        ),
                        child: DSFormfield(
                          label: 'Name on card',
                          controller: _nameOnCardController,
                          validateFunction: Validators.notEmpty(),
                          hintText: 'Enter name on card',
                        ),
                      ),
                    ],
                  ),
                VerticalSpacing(60),
                MapsDataSendButton(
                  isLoading: isLoading,
                  isEnabled: isEnabled(),
                  onTap: () {
                    userBalance < totalAmount
                        ? context.showError(message: 'Insuffienct funds')
                        : showPinBottomSheet();
                  },
                  title: 'Proceed',
                )
              ],
            ),
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
              _rechargeCardPrinting();
            }
          },
        ));
      },
    );
  }

  void _rechargeCardPrinting() {
    final data = RechargeCardPrintingRequest(
      id: _selectedDataId.toString(),
      pin: _pinController.text.trim(),
      range: _selectedPlanPrice ?? '',
      quantity: _quantityController.text.trim(),
      name: _nameOnCardController.text.trim(),
    );

    ref
        .read(rechargeCardPrintingNotifierProvider.notifier)
        .rechargeCardPrinting(
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
