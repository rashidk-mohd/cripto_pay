
import 'package:blizerpay/common/widgets/text_widgets.dart';
import 'package:blizerpay/constents/path_constents.dart';
import 'package:blizerpay/features/auth/screens/referal_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';

class InviteFriendWidget extends StatelessWidget {
  const InviteFriendWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 50,
            left: screenWidth * .04,
            right: screenWidth * .04,
          ),
          child: InkWell(
             onTap: () async {
        // final referal = await LocalStorage().getReferalCode();
        // shareReferal(referal);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const ReferalScreen(),
        ));
      },
            child: Container(
                // width: screenWidth * 06,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF0E355D),
                      Color(0xFF1D6FC3),
                    ],
                    stops: [0.021, 0.9481],
                  ),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Container(
                        width: screenWidth * 0.12,
                        height: screenWidth * 0.12,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                            child: SvgPicture.asset(PathConstents.friendsIcon)),
                      ),
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: DmSansFontText(
                              text: "Invite Friends",
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10, left: 15),
                          child: DmSansFontText(
                              text:
                                  "Earn \$200 dollar for each friend you invite ",
                              fontSize: 10,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    )
                  ],
                )),
          ),
        ),
      ],
    );
  }

  void shareReferal(String? referal) async {
    try {
      await Share.shareUri(
          Uri.parse('https://register.blizerpay.com/signup/$referal'));
    } catch (e) {
      print('Error sharing image: $e');
    }
  }
}
