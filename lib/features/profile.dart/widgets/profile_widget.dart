
import 'package:blizerpay/constents/path_constents.dart';
import 'package:blizerpay/features/profile.dart/widgets/profile_detials_widget.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
         ProfileDetaileWidget(
              path: PathConstents.profileIcon,
              title: "Full Name",
              subtitle:
                  "",
              isLogOut: false,
            ),
          const Divider(
            thickness: 2,
            color: Color(0xffEDEFF6),
            endIndent: 20,
            indent: 20,
          ),
      ],
    );
  }
}