import 'package:blizerpay/constents/path_constents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({
    super.key,
    required this.title
  });
final String? title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:Text(title!) ,
      centerTitle: true,
      leading:InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back)),
      backgroundColor: Colors.white,
      actions: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset(
            PathConstents.commonmenuBar,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(50); 
}
