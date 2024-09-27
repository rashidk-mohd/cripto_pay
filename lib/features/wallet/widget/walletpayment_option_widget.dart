import 'package:blizerpay/common/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WalletPaymentOptionWidget extends StatelessWidget {
  const WalletPaymentOptionWidget(
      {super.key, required this.path, required this.onTap, required this.text});
  final String? path;
  final void Function()? onTap;
  final String? text;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 12,right: 10,top: 8,bottom: 8),
        child: InkWell(
          onTap: onTap,
          child: Column(
            children: [
              Container(
                width: screenWidth * 0.17,
                height: screenHeight * 0.08,
                decoration: BoxDecoration(
                  color:const Color(0xff2F75FD),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                    child: SvgPicture.asset(path!)),
              ),
             const SizedBox(height: 10,),
               DmSansFontText(
                  text: text,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff2A2A2A),
                )
            ],
          ),
        ),
      ),
    );
  }
}
