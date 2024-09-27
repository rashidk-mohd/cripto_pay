
import 'package:blizerpay/common/widgets/text_widgets.dart';
import 'package:blizerpay/constents/path_constents.dart';
import 'package:blizerpay/features/comming_soon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PaymentListWidget extends StatelessWidget {
  const PaymentListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 28, right: 28),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DmSansFontText(
                text: "Payment List",
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xff2A2A2A),
              ),
              DmSansFontText(
                text: "View all",
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Color(0xff2A2A2A),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            PaymentOptionWidget(
              path: PathConstents.billicon,
              text: "Bill",
            ),
            PaymentOptionWidget(
              path: PathConstents.wifiIcon,
              text: "Internet",
            ),
            PaymentOptionWidget(
              path: PathConstents.voucherIcon,
              text: "Voucher",
            ),
            PaymentOptionWidget(
              path: PathConstents.assurenceIcon,
              text: "Assurance",
            ),
          ],
        ),
      ],
    );
  }
}

class PaymentOptionWidget extends StatelessWidget {
  const PaymentOptionWidget({
    Key? key,
    required this.path,
    required this.text,
  }) : super(key: key);

  final String? path;
  final String? text;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.03),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const CommingSoonScreen(),
          ));
        },
        child: Column(
          children: [
            Container(
              width: 54.14, // Fixed width
              height: 54.14, // Fixed height
              margin: const EdgeInsets.only(left: 9), // Left margin of 9px
              decoration: BoxDecoration(
                color: const Color(0xffF6FAFD), // Adjust as needed
                borderRadius: BorderRadius.circular(15.47),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    path!,
                    width: screenWidth *
                        0.06, // Scaling the image based on screen size
                  ),
                  SizedBox(height: screenWidth * 0.02),
                ],
              ),
            ),
            Text(
              text!,
              style:
                  const TextStyle(color: Colors.black), // Optional text style
            ),
          ],
        ),
      ),
    );
  }
}
