
import 'package:blizerpay/common/widgets/blizerfi_custom_button.dart';
import 'package:blizerpay/common/widgets/text_widgets.dart';
import 'package:blizerpay/constents/path_constents.dart';
import 'package:blizerpay/core/local_storage.dart';
import 'package:blizerpay/features/auth/screens/sign_in_screen.dart';
import 'package:blizerpay/features/bottom_navigation/home/bottom_navigation_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigatoToHomeOrNot();
    super.initState();
  }

  navigatoToHomeOrNot() async {
    String isLogedIn = await LocalStorage().getToken();
    if (isLogedIn.isNotEmpty) {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => const BottomNavScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        backgroundColor: const Color(0xff1F28CA),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              child: Image.asset(
                PathConstents.splashBackground,
              ),
            ),
            const Positioned(
              bottom: 220,
              left: 20,
              right: 20,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,mainAxisSize: MainAxisSize.min,
      
                  children: [
                    DmSansFontText(
                      text: "Pay",
                      fontSize: 56,
                      fontWeight: FontWeight.w700,
                      color: Color(0xffFFFFFF),
                    ),
                    DmSansFontText(
                      text: "Manage",
                      fontSize: 56,
                      fontWeight: FontWeight.w700,
                      color: Color(0xffFFFFFF),
                    ),
                    DmSansFontText(
                      text: "Grow...",
                      fontSize: 56,
                      fontWeight: FontWeight.w700,
                      color: Color(0xffFFFFFF),
                    ),
                  ],
                ),
              ),
            ),
            const Positioned(
              bottom: 160,
              left: 20,
              right: 20,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20,left: 20),
                child: DmSansFontText(
                  text:
                      "An Easy app to manage your all payment\nand finance related needs",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffFFFFFF),
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              left: 20,
              right: 20,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: BlizerfiCustomButton(
                  gradientColor: const [Colors.white, Colors.white],
                  text: "Get Started",
                  fontWeight: FontWeight.w700,
                  borderRadius: 30,
                  textColor: const Color(0xff2A2A2A),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SignInScreen(),
                      ),
                    );
                  },
                  borderShapeRadius: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
