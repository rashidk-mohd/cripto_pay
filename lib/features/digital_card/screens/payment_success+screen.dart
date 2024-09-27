
import 'package:blizerpay/common/widgets/blizerfi_custom_button.dart';
import 'package:blizerpay/common/widgets/text_widgets.dart';
import 'package:blizerpay/constents/path_constents.dart';
import 'package:blizerpay/features/bottom_navigation/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PaymentSucessScreenDigitalCard extends StatelessWidget {
  const PaymentSucessScreenDigitalCard({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ));
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 190, left: 8, right: 8),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(PathConstents.paymentTick),
                const SizedBox(
                  height: 40,
                ),
                const DmSansFontText(
                  text: "Thank you!",
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 40,
                ),
                const DmSansFontText(
                  text: "Your digital Card has been",
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                const DmSansFontText(
                  text: "successfully activated!",
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60, right: 60),
                  child: BlizerfiCustomButton(
                    text: "Access your digital card",
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ));
                    },
                    borderRadius: 15,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
