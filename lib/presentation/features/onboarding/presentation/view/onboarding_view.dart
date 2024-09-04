import 'package:flutter/material.dart';
import 'package:mapsdata/core/extensions/build_context_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/presentation/features/login/presentation/view/login.dart';
import 'package:mapsdata/presentation/features/onboarding/presentation/widgets/onboarding_page.dart';
import 'package:mapsdata/presentation/features/sign_up/presentation/view/register.dart';
import 'package:mapsdata/presentation/general_widgets/app_button.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  static const routeName = '/onboardingScreen';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  List<Widget> buildIndicators(currentPage) {
    List<Widget> indicators = [];
    for (int i = 0; i < pages.length; i++) {
      indicators.add(
        Container(
          width: 43,
          height: 4,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            shape: BoxShape.rectangle,
            color: currentPage == i
                ? const Color(0xFF0991CC)
                : const Color(0xFFC4C4C4),
          ),
        ),
      );
    }
    return indicators;
  }

  final List<Widget> pages = [
    const OnboardingWidget(
      title: "Airtime & Data Top Up",
      description:
          "Recharge at affordable rate and get instant data activation while using your Superjara App",
      image: 'assets/images/excited_guy.png',
      selectedPage: 0,
    ),
    const OnboardingWidget(
      title: "Educational Payment",
      description:
          "Pay less for your WAEC, NECO, JAMB, IELTS and others on your Superjara App",
      image: "assets/images/woman_with_card.png",
      selectedPage: 1,
    ),
    const OnboardingWidget(
      title: "Bills Payment",
      description:
          "Get all your bills sorted with no BANK CHARGES on the Superjara App.",
      image: "assets/images/bills_payment_image.png",
      selectedPage: 2,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 5,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: pages.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return pages[index];
                  },
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: MapsDataSendButton(
                        title: "Sign Up",
                        onTap: () {
                          // StorageService().addBool('skippedOnboarding', true);
                          // return NavigationService().navigateToView(const VerifyEmailPhoneView());
                          context.pushNamed<void>(Register.routeName);
                        },
                      ),
                    ),
                    const VerticalSpacing(25),
                    InkWell(
                      onTap: () {
                        // StorageService().addBool('skippedOnboarding', true);
                        // NavigationService().navigateToView(const SignInView());
                        context.pushNamed<void>(Login.routeName);
                      },
                      child: const Text(
                        "Log In",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
