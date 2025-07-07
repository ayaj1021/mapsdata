import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/database/local_storage_impl.dart';
import 'package:mapsdata/presentation/features/dashboard/home/presentation/widgets/bvn_message.dart';
import 'package:mapsdata/presentation/features/dashboard/home/presentation/widgets/home_header_section.dart';
import 'package:mapsdata/presentation/features/dashboard/home/presentation/widgets/services_section.dart';
import 'package:mapsdata/presentation/features/dashboard/home/presentation/widgets/transaction_history_section.dart';
import 'package:mapsdata/presentation/features/dashboard/home/presentation/widgets/wallet_balance_section.dart';
import 'package:mapsdata/presentation/features/login/data/models/login_response.dart';
import 'package:mapsdata/presentation/features/notification/notifier/get_notification_notifier.dart';
import 'package:mapsdata/presentation/features/transactions/presentation/notifier/get_transactions_notifer.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';

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

  @override
  Widget build(BuildContext context) {
    final userData =
        ref.watch(getNotificationNotifer.select((v) => v.data?.user));
    final transactionList =
        ref.watch(getTransactionsNotifer.select((v) => v.data?.data ?? []));
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
              ),
              VerticalSpacing(20),
              ServicesSection(),
              VerticalSpacing(15),
              TransactionHistorySection(
                transactionList: transactionList,
              )
            ],
          ),
        ),
      )),
    );
  }
}
