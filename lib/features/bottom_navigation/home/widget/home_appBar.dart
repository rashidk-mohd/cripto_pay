
import 'package:blizerpay/features/bottom_navigation/home/widget/appbar_background_widget.dart';
import 'package:blizerpay/features/bottom_navigation/home/widget/appbar_option_widget.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
  required  this.scaffoldKey,
  required this.name,
  required this.balance
  });
  final String? name;
  final String? balance;
final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  Widget build(BuildContext context) {
    return  Stack(
      clipBehavior: Clip.none,
      children: [
        AppBarBackGroundWidget(scaffoldKey: scaffoldKey,name: name,balance: "$balance",),
        AppBarOptionWidget(amount:"$balance" ,),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(180.0);
}
