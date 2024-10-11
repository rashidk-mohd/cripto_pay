import 'package:blizerpay/common/widgets/text_widgets.dart';
import 'package:blizerpay/constents/path_constents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PaymentReciptScreen extends StatelessWidget {
  const PaymentReciptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color(0xff1D6FC3),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: DmSansFontText(
              text: "Payment Receipt",
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 30),
          Center(
            child: Stack(
              children: [
                Image.asset(PathConstents.paymentCard),
                Positioned(
                  top: 30,
                  left: MediaQuery.of(context).size.height / 15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(PathConstents.sucessIcon),
                      const DmSansFontText(
                        text: "Payment Success",
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Color(0xff717E95),
                      ),
                      const SizedBox(height: 10),
                      const DmSansFontText(
                        text: "Your payment for Wallet recharge",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff717E95),
                      ),
                      const DmSansFontText(
                        text: "has been successfully done",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff717E95),
                      ),
                      const SizedBox(height: 10),
                      const DmSansFontText(
                        text: "Total Payment",
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff717E95),
                      ),
                      const DmSansFontText(
                        text: "\$132",
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff2A2A2A),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff15508D),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {},
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                child: DmSansFontText(
                                  text: "Done",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:const EdgeInsets.all(20.0),
                        child: InkWell(
                          onTap: () {},
                          child: const DmSansFontText(
                            text: "Pay again",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff186AFA),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
