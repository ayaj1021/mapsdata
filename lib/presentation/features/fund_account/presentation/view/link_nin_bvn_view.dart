import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapsdata/core/extensions/overlay_extension.dart';
import 'package:mapsdata/core/extensions/text_theme_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/presentation/features/fund_account/data/model/link_bvn_nin_request.dart';
import 'package:mapsdata/presentation/features/fund_account/presentation/notifier/link_non_bvn_notifier.dart';
import 'package:mapsdata/presentation/general_widgets/app_button.dart';
import 'package:mapsdata/presentation/general_widgets/digit_send_form_field.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';

class LinkNinBvnView extends ConsumerStatefulWidget {
  const LinkNinBvnView({super.key});
  static const routeName = '/link-nin-bvn';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LinkNinBvnViewState();
}

class _LinkNinBvnViewState extends ConsumerState<LinkNinBvnView> {
  final ValueNotifier<bool> _isEnabled = ValueNotifier(false);
  late TextEditingController _bvnController;

  @override
  void initState() {
    _bvnController = TextEditingController()..addListener(_listener);

    super.initState();
  }

  void _listener() {
    _isEnabled.value = _bvnController.text.isNotEmpty;
  }

  @override
  void dispose() {
    _isEnabled.dispose();
    _bvnController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(linkNinBvnNotifer).state.isLoading;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 18,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Link NIN/BVN'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            children: [
              Text(
                'Kindly be aware that in accordance with the directive from the Central Bank of Nigeria (CBN), it is now necessary to associate your BVN with your virtual account.',
                style: context.textTheme.s14w600,
              ),
              VerticalSpacing(20),
              DSFormfield(
                controller: _bvnController,
                label: 'Enter your BVN',
                hintText: '12345678901',
                maxLength: 11,
                keyboardType: TextInputType.number,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Dial: *565*0# to check BVN'),
              ),
              VerticalSpacing(50),
              ValueListenableBuilder(
                  valueListenable: _isEnabled,
                  builder: (context, r, c) {
                    return MapsDataSendButton(
                      isLoading: isLoading,
                      backgroundColor: AppColors.primaryColor,
                      isEnabled: r,
                      onTap: () {
                        _linkBvn();
                      },
                      title: 'Proceed',
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  void _linkBvn() {
    final data = LinkBvnNinRequest(bvn: _bvnController.text.trim());

    ref.read(linkNinBvnNotifer.notifier).linkBvn(
          request: data,
          onSuccess: (message) {
            // Handle success message
            context.showSuccess(message: message);
            Navigator.pop(context);
          },
          onError: (message) {
            // Handle error message
            context.showError(message: message);
          },
        );
  }
}
