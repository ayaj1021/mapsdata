import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/database/local_storage_impl.dart';
import 'package:mapsdata/core/extensions/text_theme_extension.dart';
import 'package:mapsdata/presentation/features/dashboard/profile/presentation/widgets/profile_header_seaction.dart';
import 'package:mapsdata/presentation/features/login/data/models/login_response.dart';
import 'package:mapsdata/presentation/features/notification/notifier/get_notification_notifier.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  final secureStorage = SecureStorage();
  @override
  void initState() {
    getUserDetails();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(getNotificationNotifer.notifier).getNotification(
            onSuccess: (message) {},
          );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          ProfileHeaderSection(),
          VerticalSpacing(20),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                    'assets/images/user_profile.jpg',
                  ),
                ),
                VerticalSpacing(20),
                ProfileDetailsWidget(
                  title: 'First name',
                  subTitle: user?.firstname ?? '',
                ),
                VerticalSpacing(10),
                ProfileDetailsWidget(
                  title: 'Last name',
                  subTitle: user?.lastname ?? '',
                ),
                VerticalSpacing(10),
                ProfileDetailsWidget(
                  title: 'Phone number',
                  subTitle: user?.phoneNumber ?? '',
                ),
                VerticalSpacing(10),
                ProfileDetailsWidget(
                  title: 'Email',
                  subTitle: user?.email ?? '',
                ),
                VerticalSpacing(10),
                ProfileDetailsWidget(
                  title: 'API Key',
                  subTitle: user?.apikey ?? '',
                  isLongText: true,
                ),
                VerticalSpacing(10),
                ProfileDetailsWidget(
                  title: 'Log out',
                  subTitle: user?.apikey ?? '',
                  isIcon: true,
                  onTap: () {
                    secureStorage.clearStorage();
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

class ProfileDetailsWidget extends StatelessWidget {
  const ProfileDetailsWidget({
    super.key,
    required this.title,
    required this.subTitle,
    this.hasDivider = true,
    this.isLongText,
    this.isIcon,
    this.onTap,
  });
  final String title;
  final String subTitle;
  final bool hasDivider;
  final bool? isLongText;
  final bool? isIcon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: context.textTheme.s14w500,
            ),
            Spacer(),
            isIcon == true
                ? GestureDetector(
                    onTap: onTap,
                    child: Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                  )
                : SizedBox(
                    width: isLongText == true ? 200 : null,
                    child: Text(
                      subTitle,
                      style: context.textTheme.s12w400.copyWith(),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
          ],
        ),
        VerticalSpacing(10),
        if (hasDivider)
          Divider(
            thickness: 1,
            color: Colors.grey[300]!,
          ),
      ],
    );
  }
}
