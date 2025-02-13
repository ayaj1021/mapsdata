import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/extensions/overlay_extension.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/presentation/features/airtime_topup/data/model/buy_airtime_request.dart';
import 'package:mapsdata/presentation/features/airtime_topup/presentation/notifier/buy_airtime_notifier.dart';
import 'package:mapsdata/presentation/features/airtime_topup/presentation/widgets/airtime_topup_header_section.dart';
import 'package:mapsdata/presentation/features/airtime_topup/presentation/widgets/enter_airtime_amount_section.dart';
import 'package:mapsdata/presentation/features/airtime_topup/presentation/widgets/network_selection_section.dart';
import 'package:mapsdata/presentation/features/airtime_topup/presentation/widgets/select_phone_number_section.dart';
import 'package:mapsdata/presentation/features/airtime_topup/presentation/widgets/set_pin_message.dart';
import 'package:mapsdata/presentation/general_widgets/app_button.dart';
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
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setPinNotificationAlert(context);
    });
    _phoneNumberController = TextEditingController()..addListener(_listener);
    _airtimeAmountController = TextEditingController()..addListener(_listener);
    super.initState();
  }

  void _listener() {
    _isBuyAirtimeEnabled.value = _phoneNumberController.text.isNotEmpty &&
        _airtimeAmountController.text.isNotEmpty;
  }

  int? selectedLogoIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const AirtimeTopupHeaderSection(),
            const VerticalSpacing(30),
            NetworkSelectionSection(
              selectedLogoIndex: selectedLogoIndex,
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
                  return Consumer(builder: (context, ref, child) {
                    final isLoading = ref.watch(
                      buyAirtimeNotifer
                          .select((v) => v.buyAirtimeState.isLoading),
                    );
                    return MapsDataSendButton(
                      isLoading: isLoading,
                      isEnabled: r && !isLoading,
                      onTap: () {
                        _buyAirtime();
                      },
                      title: 'Proceed',
                    );
                  });
                })
          ],
        ),
      )),
    );
  }

  void _buyAirtime() {
    final data = BuyAirtimeRequest(
      id: selectedLogoIndex.toString(),
      pin: '4321',
      number: _phoneNumberController.text.trim(),
      amount: _airtimeAmountController.text.trim(),
    );
    ref.read(buyAirtimeNotifer.notifier).login(
          data: data,
          onError: (error) {
            context.showError(message: error);
          },
          onSuccess: (message) {
            context.showSuccess(message: message);
            //  _isLoginEnabled.value = false;

            //  context.replaceAll(Dashboard.routeName);
          },
        );
  }
}
