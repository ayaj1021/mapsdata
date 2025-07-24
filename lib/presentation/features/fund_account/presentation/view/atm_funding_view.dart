import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/extensions/overlay_extension.dart';
import 'package:mapsdata/core/extensions/text_theme_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/core/utils/validators.dart';
import 'package:mapsdata/presentation/features/airtime_topup/presentation/widgets/airtime_topup_header_section.dart';
import 'package:mapsdata/presentation/features/fund_account/data/model/atm_funding_response.dart';
import 'package:mapsdata/presentation/features/fund_account/presentation/notifier/atm_funding_notifier.dart';
import 'package:mapsdata/presentation/general_widgets/app_button.dart';
import 'package:mapsdata/presentation/general_widgets/digit_send_form_field.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';

class AtmFundingView extends ConsumerStatefulWidget {
  const AtmFundingView({super.key});
  static const String routeName = '/atm_funding';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AtmFundingViewState();
}

class _AtmFundingViewState extends ConsumerState<AtmFundingView> {
  final ValueNotifier<bool> _isEnabled = ValueNotifier(false);
  late TextEditingController _amountController;

  @override
  void initState() {
    _amountController = TextEditingController()..addListener(_listener);
    super.initState();
  }

  void _listener() {
    _isEnabled.value = _amountController.text.isNotEmpty;
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  bool showPaymentOptions = false;

  int? selectedId;

  @override
  Widget build(BuildContext context) {
    final paymentOptions = ref.watch(atmFundingNotifer.select((v) => v.data));
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppHeaderSection(
              title: 'ATM Funding',
            ),
            VerticalSpacing(30),
            Text(
              'Fund Wallet',
              style: context.textTheme.s18w700,
            ),
            VerticalSpacing(10),
            Text(
              'Enter amount you wish to fund your wallet and select any of the payment gateway',
              style: context.textTheme.s14w400,
            ),
            VerticalSpacing(25),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                // color: AppColors.white,
              ),
              child: DSFormfield(
                onChange: (value) {
                  if (value.isNotEmpty) {
                    ref.read(atmFundingNotifer.notifier).atmFunding(
                        onError: (error) {
                      context.showError(message: error);
                    }, onSuccess: (message) {
                      context.showSuccess(message: message);
                      setState(() {
                        showPaymentOptions = true;
                      });
                    });
                  }
                },
                label: 'Amount',
                controller: _amountController,
                validateFunction: Validators.notEmpty(),
                hintText: 'Enter amount',
                keyboardType: TextInputType.number,
              ),
            ),
            if (showPaymentOptions)
              Column(
                children: [
                  PaymentOptionsWidget(
                    isSelected: selectedId == 0,
                    onTap: () {
                      setState(() {
                        selectedId = 0;
                      });
                    },
                    id: 0,
                    merchantTitle: 'Paystack',
                    amountController: _amountController,
                    paymentOptions: paymentOptions,
                    charges: paymentOptions?.paystack?.charge ?? 0,
                  ),
                  VerticalSpacing(10),
                  PaymentOptionsWidget(
                    isSelected: selectedId == 1,
                    onTap: () {
                      setState(() {
                        selectedId = 1;
                      });
                    },
                    id: 1,
                    merchantTitle: 'Monnify',
                    amountController: _amountController,
                    paymentOptions: paymentOptions,
                    charges: paymentOptions?.monnify?.charge ?? 0,
                  ),
                ],
              ),
            VerticalSpacing(55),
            ValueListenableBuilder(
                valueListenable: _isEnabled,
                builder: (context, r, c) {
                  return MapsDataSendButton(
                    isEnabled: r && selectedId != null,
                    onTap: () {},
                    title: 'Proceed',
                  );
                }),
          ],
        ),
      )),
    );
  }
}

class PaymentOptionsWidget extends StatelessWidget {
  const PaymentOptionsWidget({
    super.key,
    required TextEditingController amountController,
    required this.paymentOptions,
    required this.merchantTitle,
    required this.charges,
    required this.isSelected,
    required this.id,
    this.onTap,
  }) : _amountController = amountController;

  final TextEditingController _amountController;
  final AtmFundingResponse? paymentOptions;
  final String merchantTitle;
  final int charges;
  final bool isSelected;
  final int id;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? AppColors.primary0064FF
                        : AppColors.primaryA29FB3,
                  ),
                  child: isSelected
                      ? Icon(
                          Icons.check,
                          size: 10,
                          color: AppColors.white,
                        )
                      : SizedBox.shrink(),
                ),
                HorizontalSpacing(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      merchantTitle,
                      style: context.textTheme.s14w400,
                    ),
                    Text(
                      'Merchant charge',
                      style: context.textTheme.s12w300.copyWith(
                        color: AppColors.primary0064FF,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'N${_amountController.text}',
                  style: context.textTheme.s14w500
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  '-N$charges',
                  style: context.textTheme.s12w300
                      .copyWith(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
