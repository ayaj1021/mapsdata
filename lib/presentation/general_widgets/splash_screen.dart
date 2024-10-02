import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapsdata/core/database/local_storage_impl.dart';
import 'package:mapsdata/core/extensions/build_context_extension.dart';
import 'package:mapsdata/presentation/features/dashboard/widgets/dasboard.dart';
import 'package:mapsdata/presentation/features/onboarding/presentation/view/onboarding_view.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  static const routeName = '/';

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  SecureStorage secureStorage = SecureStorage();
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () async {
      final token = await secureStorage.getUserToken();

      log('token is ${token.toString()}');
      if (token != null) {
        context.pushReplacementNamed(Dashboard.routeName);
      } else {
        context.pushReplacementNamed(OnboardingScreen.routeName);
      }
      // Navigator.pushReplacementNamed(context, OnboardingScreen.routeName);
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
