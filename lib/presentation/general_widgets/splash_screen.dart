import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapsdata/presentation/features/onboarding/presentation/view/onboarding_view.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  static const routeName = '/';

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () async{
      //   final storage = await SecureStorage();
      // final token = await storage.getUserToken();
     //debugPrint('token is $token');
      // if (token != null) {
      //   Navigator.pushReplacementNamed(context, Login.routeName);
      // } else {
        Navigator.pushReplacementNamed(context, OnboardingScreen.routeName);
     // }
      // final userState = ref.read(userAuthRepositoryProvider);
      // switch (userState.getCurrentState()) {
      //   case CurrentState.initial:
      //     Navigator.pushReplacementNamed(context, Onboarding.routeName);
      //   default:
      //     Navigator.pushReplacementNamed(context, Login.routeName);
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 100.h,
              width: 100.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Image.asset(
                  'assets/logo/mapsdata_logo.jpg',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
