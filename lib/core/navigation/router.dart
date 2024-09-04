

import 'package:flutter/widgets.dart';
import 'package:mapsdata/presentation/features/dashboard/widgets/dasboard.dart';
import 'package:mapsdata/presentation/features/login/presentation/view/forgot_password.dart';
import 'package:mapsdata/presentation/features/login/presentation/view/login.dart';
import 'package:mapsdata/presentation/features/onboarding/presentation/view/onboarding_view.dart';
import 'package:mapsdata/presentation/features/sign_up/presentation/view/register.dart';
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


  };
  static Map<String, Widget Function(BuildContext)> get routes => _routes;
}
