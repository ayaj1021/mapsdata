import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/extensions/overlay_extension.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/core/utils/page_loader.dart';
import 'package:mapsdata/presentation/features/airtime_topup/presentation/widgets/select_phone_number_section.dart';
import 'package:mapsdata/presentation/features/data_topup/data/model/buy_data_request.dart';
import 'package:mapsdata/presentation/features/data_topup/data/model/get_data_response_model.dart';
import 'package:mapsdata/presentation/features/data_topup/presentation/notifier/buy_data_notifier.dart';
import 'package:mapsdata/presentation/features/data_topup/presentation/notifier/get_all_data_plans_notifier.dart';
import 'package:mapsdata/presentation/features/data_topup/presentation/widgets/data_network_selection_widget.dart';
import 'package:mapsdata/presentation/features/data_topup/presentation/widgets/data_plan_widget.dart';
import 'package:mapsdata/presentation/features/data_topup/presentation/widgets/data_topup_header_section.dart';
import 'package:mapsdata/presentation/features/data_topup/presentation/widgets/data_type_widget.dart';
import 'package:mapsdata/presentation/features/notification/notifier/get_notification_notifier.dart';
import 'package:mapsdata/presentation/general_widgets/app_button.dart';
import 'package:mapsdata/presentation/general_widgets/ds_bottom_sheet.dart';
import 'package:mapsdata/presentation/general_widgets/input_pin_bottomsheet.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';

class BuyDataScreen extends ConsumerStatefulWidget {
  const BuyDataScreen({super.key});
  static const routeName = '/buyData';

  @override
  ConsumerState<BuyDataScreen> createState() => _BuyDataScreenState();
}

class _BuyDataScreenState extends ConsumerState<BuyDataScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref
          .read(getAllDataPlansNotifierProvider.notifier)
          .getAllDataPlans();
    });
  }

  List<Plan> filteredPlans = [];

  void _onDataProviderSelected(
      String selectedNetworkProvider, List<Plan> allPlans) {
    setState(() {
      _selectedNetwork = selectedNetworkProvider;
      _selectedType = null; // Reset type when network changes
      _selectedPlan = null; // Reset plan when network changes
      _selectedPlanPrice = null; // Reset price when network changes
      _updateFilteredPlans(
          allPlans); // Update filtered plans based on the new network
    });
  }

  void _updateFilteredPlans(List<Plan> allPlans) {
    filteredPlans = allPlans.where((plan) {
      final matchesNetwork =
          _selectedNetwork == null || plan.network == _selectedNetwork;
      final matchesType =
          selectedPlanType == null || plan.type == selectedPlanType;
      return matchesNetwork && matchesType;
    }).toList();
  }

  void _onTypeSelected(String selectedType, List<Plan>? dataPlans) {
    setState(() {
      _selectedType = selectedType;
      _selectedPlan = null; // Reset plan when type changes
      _selectedPlanPrice = null; // Reset price when type changes
      _updateFilteredPlans(
          dataPlans ?? []); // Update filtered plans based on the new type
    });
  }

  void _onPlanSelected(String selectedNetwork) {
    setState(() {
      _selectedPlan = selectedNetwork;
      _selectedPlanPrice = null;
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

  final _phoneNumberController = TextEditingController();
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
    if (_selectedNetwork != null ||
        _phoneNumberController.text.isNotEmpty ||
        _selectedType != null ||
        _selectedPlan != null) {
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
        buyDataNotifierProvider.select((state) => state.state.isLoading));
    final dataPlans = ref.watch(getAllDataPlansNotifierProvider
        .select((v) => v.data?.plans?.toList() ?? []));

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
                const DataTopupHeaderSection(),
                const VerticalSpacing(30),
                DataNetworkSelection(
                  selectedNetwork: _selectedNetwork,
                  dataPlans: dataPlans,
                  onNidSelected: _onNidSelected,
                  selectedNid: _selectedNid.toString(),
                  onNetworkSelected: (selectedCableProvider) =>
                      _onDataProviderSelected(selectedCableProvider, dataPlans),
                ),
                const VerticalSpacing(20),
                SelectPhoneNumberSection(
                  phoneNumberController: _phoneNumberController,
                ),
                const VerticalSpacing(20),
                DataTypeWidget(
                  selectedNetwork: _selectedNetwork,
                  selectedType: _selectedType,
                  dataPlans: dataPlans,
                  ontypeSelected: (selectedType) =>
                      _onTypeSelected(selectedType, dataPlans),
                ),
                const VerticalSpacing(20),
                DataPlanWidget(
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
                VerticalSpacing(60),
                MapsDataSendButton(
                  isLoading: isLoading,
                  isEnabled: isEnabled(),
                  onTap: () {
                    userBalance < num.parse(_selectedPlanPrice ?? '')
                        ? context.showError(message: 'Insuffienct funds')
                        : showPinBottomSheet();
                  },
                  title: 'Buy Data',
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
              _buyData();
            }
          },
        ));
      },
    );
  }

  void _buyData() {
    final data = BuyDataRequest(
        id: _selectedDataId.toString(),
        pin: '1111',
        number: _phoneNumberController.text.trim());

    ref.read(buyDataNotifierProvider.notifier).buyData(
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
