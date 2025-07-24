import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mapsdata/core/database/local_storage_impl.dart';
import 'package:mapsdata/core/extensions/overlay_extension.dart';
import 'package:mapsdata/core/extensions/text_theme_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/presentation/features/dashboard/home/presentation/widgets/bvn_message.dart';
import 'package:mapsdata/presentation/features/dashboard/home/presentation/widgets/home_header_section.dart';
import 'package:mapsdata/presentation/features/dashboard/home/presentation/widgets/services_section.dart';
import 'package:mapsdata/presentation/features/dashboard/home/presentation/widgets/transaction_history_section.dart';
import 'package:mapsdata/presentation/features/dashboard/home/presentation/widgets/wallet_balance_section.dart';
import 'package:mapsdata/presentation/features/login/data/models/login_response.dart';
import 'package:mapsdata/presentation/features/notification/notifier/get_notification_notifier.dart';
import 'package:mapsdata/presentation/features/transactions/presentation/notifier/get_transactions_notifer.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final secureStorage = SecureStorage();
  @override
  void initState() {
    getUserDetails();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(getNotificationNotifer.notifier).getNotification(
        onSuccess: (message) {
          bvnNotificationAlert(context, message: message);
        },
      );
      ref.read(getTransactionsNotifer.notifier).getTransactions();
    });
    super.initState();
  }

  User? user;

  getUserDetails() async {
    final userData = await secureStorage.getStoredProfile();
    if (userData != null) {
      setState(() {
        user = userData;
      });
    }
  }

  Future<void> _onRefresh() {
    return ref.read(getNotificationNotifer.notifier).getNotification(
          onSuccess: (message) {},
        );
  }

  Future<void> openWhatsAppChannel(String uri) async {
    final Uri url = Uri.parse(uri);

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userData =
        ref.watch(getNotificationNotifer.select((v) => v.data?.user));
    final whatsappData =
        ref.watch(getNotificationNotifer.select((v) => v.data));
    final transactionList =
        ref.watch(getTransactionsNotifer.select((v) => v.data?.data ?? []));
    final referLink =
        "https://app.mapsdata.com.ng/register?ref=${user?.username ?? ''}";
    return Scaffold(
      body: SafeArea(
          child: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              HomeHeaderSection(
                userName: user?.firstname ?? '',
              ),
              VerticalSpacing(30),
              WalletBalanceSection(
                walletBalance: '${userData?.wallet ?? ''}',
                commission: userData?.commission ?? '',
              ),
              VerticalSpacing(20),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                    color: Colors.green.shade100.withAlpha((0.5 * 255).toInt()),
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/whatsapp.svg',
                          height: 26,
                          width: 26,
                        ),
                        HorizontalSpacing(5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Whatsapp group',
                              style: context.textTheme.s14w500
                                  .copyWith(color: AppColors.primary005304),
                            ),
                            Text(
                              'Join our group for updates',
                              style: context.textTheme.s10w400,
                            ),
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        openWhatsAppChannel(whatsappData?.whatsapp?.link ?? '');
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                            color: AppColors.primary005304,
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          'Join Now',
                          style: context.textTheme.s12w500.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              VerticalSpacing(20),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/icons/refer_earn.png',
                          height: 46,
                        ),
                        HorizontalSpacing(5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Refer & Earn',
                              style: context.textTheme.s14w500
                                  .copyWith(color: AppColors.primary005304),
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.5,
                              child: Text(
                                referLink,
                                style: context.textTheme.s10w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: referLink));
                          context.showToast(message: 'Copied successfully');
                        },
                        child: Icon(Icons.copy))
                  ],
                ),
              ),
              VerticalSpacing(20),
              ServicesSection(),
              VerticalSpacing(15),
              TransactionHistorySection(
                transactionList: transactionList,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
