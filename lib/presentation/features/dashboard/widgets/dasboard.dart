import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/presentation/features/dashboard/history/presentation/view/history.dart';
import 'package:mapsdata/presentation/features/dashboard/home/presentation/view/home.dart';
import 'package:mapsdata/presentation/features/dashboard/profile/presentation/view/profile.dart';
import 'package:mapsdata/presentation/features/dashboard/support/presentation/view/support.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  static const routeName = '/dashboard';

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List pages = [
    const Home(),
    const History(),
    const Support(),
    const Profile()
  ];

  int selectedIndex = 0;

  void changePage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.primaryColor,
        elevation: 0,
        currentIndex: selectedIndex,
        onTap: (index) {
          changePage(index);
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: SizedBox(
                  height: 24.h,
                  width: 24.w,
                  child: const Icon(Icons.home_outlined)),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: SizedBox(
                height: 24.h,
                width: 24.w,
                child: const Icon(Icons.history),
              ),
              label: 'History'),
          BottomNavigationBarItem(
              icon: SizedBox(
                  height: 24.h,
                  width: 24.w,
                  child: const Icon(Icons.support_agent)),
              label: 'Support'),
          BottomNavigationBarItem(
              icon: SizedBox(
                height: 24.h,
                width: 24.w,
                child: const Icon(Icons.person),
              ),
              label: 'Profile')
        ],
      ),
    );
  }
}
