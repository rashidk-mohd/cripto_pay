import 'package:blizerpay/common/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class ProfileDetaileWidget extends StatelessWidget {
  ProfileDetaileWidget(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.path,
      required this.isLogOut});

  final String? title;
  final String? subtitle;
  final String? path;
  bool isLogOut = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 30,
        top: 10
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey[200],
            child: SvgPicture.asset(
              path!,
              width: 20,
              height: 20,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Ensure Edit is aligned to the right
                children: [
                  DmSansFontText(
                    text: title ?? "",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff717E95),
                  ),
                 
                ],
              ),
              DmSansFontText(
                text: subtitle ?? "",
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: const Color(0xff2A2A2A),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
