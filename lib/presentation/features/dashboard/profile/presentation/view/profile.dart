import 'package:flutter/material.dart';
import 'package:mapsdata/presentation/features/dashboard/profile/presentation/widgets/profile_header_seaction.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Column(
        children: [
          ProfileHeaderSection()
        ],
      )),
    );
  }
}