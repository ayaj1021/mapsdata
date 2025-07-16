import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/extensions/overlay_extension.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/core/utils/page_loader.dart';
import 'package:mapsdata/presentation/features/airtime_topup/data/model/buy_airtime_request.dart';
import 'package:mapsdata/presentation/features/airtime_topup/data/model/fetch_airtime_list_model.dart';
import 'package:mapsdata/presentation/features/airtime_topup/presentation/notifier/buy_airtime_notifier.dart';
import 'package:mapsdata/presentation/features/airtime_topup/presentation/notifier/get_airtime_plans_notifier.dart';
import 'package:mapsdata/presentation/features/airtime_topup/presentation/widgets/airtime_network_dropdown.dart';
import 'package:mapsdata/presentation/features/airtime_topup/presentation/widgets/airtime_topup_header_section.dart';
import 'package:mapsdata/presentation/features/airtime_topup/presentation/widgets/enter_airtime_amount_section.dart';
import 'package:mapsdata/presentation/features/airtime_topup/presentation/widgets/select_phone_number_section.dart';
import 'package:mapsdata/presentation/features/notification/notifier/get_notification_notifier.dart';
import 'package:mapsdata/presentation/features/set_pin/data/model/set_pin_request.dart';
import 'package:mapsdata/presentation/features/set_pin/presentation/notifier/set_pin_notifier.dart';
import 'package:mapsdata/presentation/features/set_pin/presentation/view/set_pin_message.dart';
import 'package:mapsdata/presentation/general_widgets/app_button.dart';
import 'package:mapsdata/presentation/general_widgets/ds_bottom_sheet.dart';
import 'package:mapsdata/presentation/general_widgets/input_pin_bottomsheet.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';

class AirtimeTopupScreen extends ConsumerStatefulWidget {
  const AirtimeTopupScreen({super.key});
  static const routeName = '/airtimeTopup';

  @override
  ConsumerState<AirtimeTopupScreen> createState() => _AirtimeTopupScreenState();
}

class _AirtimeTopupScreenState extends ConsumerState<AirtimeTopupScreen> {
  final ValueNotifier<bool> _isBuyAirtimeEnabled = ValueNotifier(false);
  late TextEditingController _phoneNumberController;
  late TextEditingController _airtimeAmountController;
  final _setPinController = TextEditingController();
  String? _selectedNetwork;
  String? _selectedNid;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final isLoading =
          ref.watch(setPinNotifer.select((v) => v.state.isLoading));
      await ref.read(getAirtimePlansNotifierProvider.notifier).getAirtimePlans(
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
    _phoneNumberController = TextEditingController()..addListener(_listener);
    _airtimeAmountController = TextEditingController()..addListener(_listener);
    super.initState();
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

  List<AirtimeItem> filteredPlans = [];
  void _onDataProviderSelected(
      String selectedNetworkProvider, List<AirtimeItem> allPlans) {
    setState(() {
      _selectedNetwork = selectedNetworkProvider;
      // Reset price when network changes
      // _updateFilteredPlans(
      //     allPlans); // Update filtered plans based on the new network
    });
  }

  void _listener() {
    _isBuyAirtimeEnabled.value = _phoneNumberController.text.isNotEmpty &&
        _airtimeAmountController.text.isNotEmpty;
  }

  void _onNidSelected(String selectedNid) {
    setState(() {
      _selectedNid = selectedNid;
    });
  }

  int? selectedLogoIndex;

  final _pinController = TextEditingController();
  @override
  void dispose() {
    _pinController.dispose();
    _phoneNumberController.dispose();
    _airtimeAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final airtimePlans = ref.watch(getAirtimePlansNotifierProvider
        .select((v) => v.data?.airtime?.toList() ?? []));

    final isAirtimePlansLoading = ref.watch(
        getAirtimePlansNotifierProvider.select((v) => v.state.isLoading));
    final isLoading = ref.watch(
      buyAirtimeNotifierProvider.select((v) => v.state.isLoading),
    );
    final userData =
        ref.watch(getNotificationNotifer.select((v) => v.data?.user));
    final userBalance = userData?.wallet ?? 0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageLoader(
        isLoading: isAirtimePlansLoading,
        child: PageLoader(
          isLoading: isLoading,
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const CustomAppHeaderSection(
                  title: 'Airtime Topup',
                ),
                const VerticalSpacing(30),
                AirtimeNetworkSelection(
                  selectedNetwork: _selectedNetwork,
                  airtimePlans: airtimePlans,
                  onNidSelected: _onNidSelected,
                  selectedNid: _selectedNid.toString(),
                  onNetworkSelected: (selectedCableProvider) =>
                      _onDataProviderSelected(
                          selectedCableProvider, airtimePlans),
                ),
                const VerticalSpacing(30),
                SelectPhoneNumberSection(
                  phoneNumberController: _phoneNumberController,
                ),
                const VerticalSpacing(20),
                EnterAirtimeAmountSection(
                  amountController: _airtimeAmountController,
                ),
                const VerticalSpacing(40),
                ValueListenableBuilder(
                  valueListenable: _isBuyAirtimeEnabled,
                  builder: (context, r, c) {
                    return MapsDataSendButton(
                      //  isLoading: isLoading,
                      isEnabled: r && !isLoading,
                      onTap: () {
                        userBalance < num.parse(_airtimeAmountController.text)
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
              _buyAirtime();
            }
          },
        ));
      },
    );
  }

  void _buyAirtime() {
    final data = BuyAirtimeRequest(
      id: _selectedNid.toString(),
      pin: _pinController.text.trim(),
      number: _phoneNumberController.text.trim(),
      amount: _airtimeAmountController.text.trim(),
    );
    ref.read(buyAirtimeNotifierProvider.notifier).buyAirtime(
          request: data,
          onError: (error) {
            context.showError(message: error);
          },
          onSuccess: (message) {
            context.showSuccess(message: message);
            ref.read(getNotificationNotifer.notifier).getNotification(
                  onSuccess: (message) {},
                );
            _pinController.clear();
          },
        );
  }
}
