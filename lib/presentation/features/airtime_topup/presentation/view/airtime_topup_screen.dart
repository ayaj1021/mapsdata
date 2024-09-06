import 'package:flutter/material.dart';
import 'package:mapsdata/presentation/features/airtime_topup/presentation/widgets/airtime_topup_header_section.dart';
import 'package:mapsdata/presentation/features/airtime_topup/presentation/widgets/enter_airtime_amount_section.dart';
import 'package:mapsdata/presentation/features/airtime_topup/presentation/widgets/network_selection_section.dart';
import 'package:mapsdata/presentation/features/airtime_topup/presentation/widgets/select_phone_number_section.dart';
import 'package:mapsdata/presentation/features/airtime_topup/presentation/widgets/set_pin_message.dart';
import 'package:mapsdata/presentation/general_widgets/app_button.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';

class AirtimeTopupScreen extends StatefulWidget {
  const AirtimeTopupScreen({super.key});
  static const routeName = '/airtimeTopup';

  @override
  State<AirtimeTopupScreen> createState() => _AirtimeTopupScreenState();
}

class _AirtimeTopupScreenState extends State<AirtimeTopupScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setPinNotificationAlert(context);
    });
    super.initState();
  }

  final _phoneNumberController = TextEditingController();
  final _airtimeAmountController = TextEditingController();
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
            const NetworkSelectionSection(),
            const VerticalSpacing(30),
            SelectPhoneNumberSection(
              phoneNumberController: _phoneNumberController,
            ),
            const VerticalSpacing(20),
            EnterAirtimeAmountSection(
              amountController: _airtimeAmountController,
            ),
            const VerticalSpacing(40),
            MapsDataSendButton(onTap: (){}, title: 'Proceed')
          ],
        ),
      )),
    );
  }
}
