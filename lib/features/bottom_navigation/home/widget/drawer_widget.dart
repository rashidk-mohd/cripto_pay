
import 'package:blizerpay/common/widgets/text_widgets.dart';
import 'package:blizerpay/constents/path_constents.dart';
import 'package:blizerpay/features/auth/controller/auth_controller.dart';
import 'package:blizerpay/features/comming_soon.dart';
import 'package:blizerpay/features/history/screens/history_screen.dart';
import 'package:blizerpay/features/profile.dart/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

final authController = ChangeNotifierProvider<AuthController>((ref) {
  return AuthController();
});

class HomeDrawerWidget extends ConsumerWidget {
  const HomeDrawerWidget(
      {super.key,
      required this.name,
      required this.email,
      required this.imageUrl});
  final String? name;
  final String? imageUrl;
  final String? email;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(
              width: 4.0,
            ),
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, top: 20),
              child: _buildUserProfile(context, name, imageUrl, email),
            ),
            const SizedBox(
              height: 40,
            ),
            DrawerContentWidget(
              path: PathConstents.profileIcon,
              title: "Edit Profile",
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ));
              },
            ),
            DrawerContentWidget(
              path: PathConstents.historyIcon,
              title: "History",
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const HistoryScreen(),
                ));
              },
            ),

             DrawerContentWidget(
 onTap: () {
                 Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CommingSoonScreen(),
                  ));
              },
              path: PathConstents.helpIcon,
              title: "Help",
            ),
            // DrawerContentWidget(
            //   path: PathConstents.passwordIcon,
            //   title: "Change Password",
            //   onTap: () {
            //     Navigator.of(context).push(MaterialPageRoute(
            //       builder: (context) => ChangePasswordScreen(),
            //     ));
            //   },
            // ),
            DrawerContentWidget(

              path: PathConstents.settingsIcon,
              title: "Notification Settings",
              onTap: () {
                 Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CommingSoonScreen(),
                  ));
              },
            ),
            DrawerContentWidget(
              onTap: () {
                showSignoutDialog(context, ref);
              },
              path: PathConstents.logoutIcon,
              title: "Log out",
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildUserProfile(
    BuildContext context, String? name, String? imageUrl, String? email) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        imageUrl!.isNotEmpty
            ? CircleAvatar(
                radius: 40.0, backgroundImage: NetworkImage(imageUrl!))
            : CircleAvatar(
                backgroundColor: const Color(0xffC4C4C4),
                radius: 40,
                child: SvgPicture.asset(
                  PathConstents.profileicon,
                  height: 40,
                  width: 40,
                  color: Colors.white,
                ),
              ),
        const SizedBox(height: 10),
        DmSansFontText(
          text: name,
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: const Color(0xff2A2A2A),
        ),
        const SizedBox(height: 5),
        DmSansFontText(
          text: email,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Color(0xff2A2A2A),
        ),
      ],
    ),
  );
}



class DrawerContentWidget extends StatelessWidget {
  const DrawerContentWidget({
    Key? key,
    this.path,
    this.title,
    this.onTap,
  }) : super(key: key);

  final String? path;
  final String? title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 8, bottom: 10, top: 10),
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                path!,
                width: path == PathConstents.contactIcon ||
                        path == PathConstents.helpIcon
                    ? 18
                    : 24,
                height: path == PathConstents.contactIcon ||
                        path == PathConstents.helpIcon
                    ? 18
                    : 24,
              ),
            ),
            const SizedBox(width: 10),
            // Wrap the text in Flexible to handle overflow and alignment
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  title ?? "",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff2A2A2A),
                  ),
                  overflow: TextOverflow.ellipsis, // Handle overflow
                  maxLines: 1, // Limit text to one line
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
