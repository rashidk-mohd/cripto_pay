import 'package:blizerpay/common/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ReferalOptionWidgets extends StatelessWidget {
  const ReferalOptionWidgets({super.key, this.title, this.subTitle, this.path});
  final String? title;
  final String? subTitle;
  final String? path;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth * 0.9,
      height: screenHeight * 0.07,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 1,
          color: const Color(0xffE1E1E1),
          style: BorderStyle.solid,
        ),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(path!),
          ),
          SizedBox(width: screenWidth * 0.05),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.01),
              DmSansFontText(
                text: title,
                fontSize: screenHeight * 0.022,
                fontWeight: FontWeight.w700,
                color: const Color(0xff2A2A2A),
              ),
              DmSansFontText(
                text: subTitle,
                fontSize: screenHeight * 0.015,
                fontWeight: FontWeight.w500,
                color: const Color(0xff717E95),
              ),
            ],
          )
        ],
      ),
    );
  }
}
