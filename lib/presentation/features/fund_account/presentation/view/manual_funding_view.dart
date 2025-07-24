import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/extensions/overlay_extension.dart';
import 'package:mapsdata/core/extensions/text_theme_extension.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/core/utils/validators.dart';
import 'package:mapsdata/presentation/features/fund_account/data/model/manual_funding_request.dart';
import 'package:mapsdata/presentation/features/fund_account/presentation/notifier/manual_funding_notifier.dart';
import 'package:mapsdata/presentation/features/fund_account/presentation/view/manual_funding_details.dart';
import 'package:mapsdata/presentation/general_widgets/app_button.dart';
import 'package:mapsdata/presentation/general_widgets/digit_send_form_field.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';

class ManualFundingView extends ConsumerStatefulWidget {
  const ManualFundingView({super.key});
  static const routeName = '/manual_funding';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ManualFundingViewState();
}

class _ManualFundingViewState extends ConsumerState<ManualFundingView> {
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

  @override
  Widget build(BuildContext context) {
    final isLoading =
        ref.watch(manualFundingNotifer.select((v) => v.state.isLoading));
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 18,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Manual Funding'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VerticalSpacing(30),
            Text(
              'No BVN required',
              style: context.textTheme.s18w700,
            ),
            VerticalSpacing(10),
            Text(
              'Enter amount you wish to fund your wallet and pay into generated account',
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
                label: 'Amount',
                controller: _amountController,
                validateFunction: Validators.notEmpty(),
                hintText: 'Enter amount',
                keyboardType: TextInputType.number,
              ),
            ),
            VerticalSpacing(55),
            ValueListenableBuilder(
                valueListenable: _isEnabled,
                builder: (context, r, c) {
                  return MapsDataSendButton(
                    isLoading: isLoading,
                    isEnabled: r,
                    onTap: () {
                      _manualFunding();
                    },
                    title: 'Proceed',
                  );
                }),
          ],
        ),
      )),
    );
  }

  void _manualFunding() {
    final data = ManualFundingRequest(amount: _amountController.text.trim());

    ref.read(manualFundingNotifer.notifier).manualFunding(
          request: data,
          onSuccess: (message, account) {
            context.showSuccess(message: message);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ManualFundingDetails(
                    accountData: account,
                  ),
                ));
          },
          onError: (error) {
            context.showError(message: error);
          },
        );
  }
}
