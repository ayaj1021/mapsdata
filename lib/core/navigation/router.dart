import 'package:flutter/widgets.dart';
import 'package:mapsdata/presentation/features/airtime_topup/presentation/view/airtime_topup_screen.dart';
import 'package:mapsdata/presentation/features/bulk_sms/presentation/view/bulk_sms_view.dart';
import 'package:mapsdata/presentation/features/cables/presentation/view/cable_view.dart';
import 'package:mapsdata/presentation/features/dashboard/widgets/dasboard.dart';
import 'package:mapsdata/presentation/features/data_card/presentation/view/data_card_view.dart';
import 'package:mapsdata/presentation/features/data_topup/presentation/view/buy_data_screen.dart';
import 'package:mapsdata/presentation/features/electricity/presentation/view/electricity_view.dart';
import 'package:mapsdata/presentation/features/fund_account/presentation/view/link_nin_bvn_view.dart';
import 'package:mapsdata/presentation/features/login/presentation/view/forgot_password.dart';
import 'package:mapsdata/presentation/features/login/presentation/view/login.dart';
import 'package:mapsdata/presentation/features/maps_venture/view/maps_venture_view.dart';
import 'package:mapsdata/presentation/features/onboarding/presentation/view/onboarding_view.dart';
import 'package:mapsdata/presentation/features/recharge_card_printing/presentation/view/recharge_card_printing_view.dart';
import 'package:mapsdata/presentation/features/register/presentation/view/register.dart';
import 'package:mapsdata/presentation/features/result_checker/presentation/view/result_checker_view.dart';
import 'package:mapsdata/presentation/general_widgets/splash_screen.dart';

class AppRouter {
  static final Map<String, Widget Function(BuildContext)> _routes = {
    SplashScreen.routeName: (context) => const SplashScreen(),
    Register.routeName: (context) => const Register(),
    Login.routeName: (context) => const Login(),
    OnboardingScreen.routeName: (context) => const OnboardingScreen(),
    ForgotPassword.routeName: (context) => const ForgotPassword(),
    // OTPVerification.routeName: (context) => const OTPVerification(),
    Dashboard.routeName: (context) => const Dashboard(),
    AirtimeTopupScreen.routeName: (context) => const AirtimeTopupScreen(),
    MapsVenture.routeName: (context) => const MapsVenture(),
    BuyDataScreen.routeName: (context) => const BuyDataScreen(),
    LinkNinBvnView.routeName: (context) => const LinkNinBvnView(),
    ResultCheckerScreen.routeName: (context) => const ResultCheckerScreen(),
    DataCardScreen.routeName: (context) => const DataCardScreen(),
    RechargeCardPrintingScreen.routeName: (context) =>
        const RechargeCardPrintingScreen(),
    BuyCableScreen.routeName: (context) => const BuyCableScreen(),
    BuyElectricityScreen.routeName: (context) => const BuyElectricityScreen(),
    BulkSms.routeName: (context) => const BulkSms(),
  };
  static Map<String, Widget Function(BuildContext)> get routes => _routes;
}
