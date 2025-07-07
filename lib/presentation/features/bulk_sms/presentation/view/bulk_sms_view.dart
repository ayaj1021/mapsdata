import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/extensions/overlay_extension.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/core/utils/page_loader.dart';
import 'package:mapsdata/core/utils/validators.dart';
import 'package:mapsdata/presentation/features/airtime_topup/presentation/widgets/airtime_topup_header_section.dart';
import 'package:mapsdata/presentation/features/bulk_sms/data/model/bulk_sms_request.dart';
import 'package:mapsdata/presentation/features/bulk_sms/presentation/notifier/bulk_sms_notifier.dart';
import 'package:mapsdata/presentation/features/notification/notifier/get_notification_notifier.dart';
import 'package:mapsdata/presentation/general_widgets/app_button.dart';
import 'package:mapsdata/presentation/general_widgets/digit_send_form_field.dart';
import 'package:mapsdata/presentation/general_widgets/ds_bottom_sheet.dart';
import 'package:mapsdata/presentation/general_widgets/input_pin_bottomsheet.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';

class BulkSms extends ConsumerStatefulWidget {
  const BulkSms({super.key});
  static const routeName = '/bulkSms';

  @override
  ConsumerState<BulkSms> createState() => _BuyCableScreenState();
}

class _BuyCableScreenState extends ConsumerState<BulkSms> {
  final ValueNotifier<bool> _isEnabled = ValueNotifier(false);
  late TextEditingController _messageController;
  late TextEditingController _senderNameController;
  late TextEditingController _phoneNumberController;
  @override
  void initState() {
    super.initState();

    _messageController = TextEditingController()..addListener(_listener);
    _senderNameController = TextEditingController()..addListener(_listener);
    _phoneNumberController = TextEditingController()..addListener(_listener);
  }

  List<String> filteredPlans = ['PREPAID', 'POSTPAID'];

  num totalAmount = 1;

  void _listener() {
    _isEnabled.value = _messageController.text.isNotEmpty &&
        _senderNameController.text.isNotEmpty &&
        _phoneNumberController.text.isNotEmpty;
  }

  final _pinController = TextEditingController();

  bool isEnabled() {
    if (_senderNameController.text.isNotEmpty &&
        _messageController.text.isNotEmpty &&
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
        bulkSmsNotifierProvider.select((state) => state.state.isLoading));

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
                  title: 'Airtime to Cash',
                ),
                const VerticalSpacing(30),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DSFormfield(
                    label: 'Sender name',
                    controller: _senderNameController,
                    validateFunction: Validators.notEmpty(),
                    hintText: 'Enter sender name',
                    keyboardType: TextInputType.number,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DSFormfield(
                    label: 'Recepient number',
                    controller: _phoneNumberController,
                    validateFunction: Validators.notEmpty(),
                    hintText: 'Enter recepient number',
                    keyboardType: TextInputType.number,
                  ),
                ),
                const VerticalSpacing(20),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    // color: AppColors.white,
                  ),
                  child: DSFormfield(
                    label: 'Message',
                    controller: _messageController,
                    hintText: 'Enter message',
                    maxLines: 5,
                  ),
                ),
                VerticalSpacing(60),
                ValueListenableBuilder(
                    valueListenable: _isEnabled,
                    builder: (context, r, c) {
                      return MapsDataSendButton(
                        isLoading: isLoading,
                        isEnabled: r,
                        onTap: () {
                          userBalance < totalAmount
                              ? context.showError(message: 'Insuffienct funds')
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
    final data = BulkSmsRequest(
      service: 'Bulk SMS',
      sender: _senderNameController.text.trim(),
      message: _messageController.text.trim(),
      phoneNumber: _phoneNumberController.text.trim(),
    );

    ref.read(bulkSmsNotifierProvider.notifier).bulkSms(
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
