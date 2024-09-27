import 'dart:convert';
import 'dart:developer';
import 'package:blizerpay/common/widgets/text_widgets.dart';
import 'package:blizerpay/constents/path_constents.dart';
import 'package:blizerpay/core/local_storage.dart';
import 'package:blizerpay/features/bottom_navigation/home/screens/home_screen.dart';
import 'package:blizerpay/features/wallet/screens/qr_screen.dart';
import 'package:blizerpay/features/wallet/screens/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class AppBarOptionWidget extends ConsumerStatefulWidget {
   AppBarOptionWidget({
    super.key,
    this.amount
  });
final String? amount;
  @override
  ConsumerState<AppBarOptionWidget> createState() =>
      _AppBarOptionWidgetConsumerState();
}

class _AppBarOptionWidgetConsumerState
    extends ConsumerState<AppBarOptionWidget> {
  TextEditingController walletIdController = TextEditingController();
  TextEditingController walletAmountController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final homeValue = ref.watch(homeChangeNotierProvider);
    return Positioned(
      bottom: -40,
      left: screenWidth * .04,
      right: screenWidth * .04,
      child: Container(
        width: screenWidth * 0.9,
        height: 80,
        decoration: BoxDecoration(
          color: const Color(0xff0E355D),
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            colors: [
              Color(0xff0E355D),
              Color(0xff1D6Fc3),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  ref
                      .read(homeChangeNotierProvider.notifier)
                      .getPersonalDetails()
                      .then(
                    (value) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const WalletScreen(),
                      ));
                    },
                  );
                  
                  //  ref.read(authController.notifier).logOut(context);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   Image.asset(PathConstents.wallet),
                    const SizedBox(height: 10),
                    const DmSansFontText(
                      text: "Wallet",
                      fontSize: 12.71,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 1,
              height: 50,
              color: Colors.white,
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>  QRScannerScreen(amount: widget.amount,),
                  ));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SvgPicture.asset(PathConstents.qrIcon),
                    Image.asset(PathConstents.qr),
                    const SizedBox(height: 10),
                    const DmSansFontText(
                      text: "QR scan",
                      fontSize: 12.71,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 1,
              height: 50,
              color: Colors.white,
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  encriptionTheIDURL();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(PathConstents.topUpIcon),
                    const SizedBox(height: 10),
                    const DmSansFontText(
                      text: "Top up",
                      fontSize: 12.71,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future encriptionTheIDURL() async {
    try {
      String? encryptedId;
      String? id = await LocalStorage().getUserID();
      encryptedId = encodeId(id!);
      launchUrl(Uri.parse("https://walletconnect.blizerpay.com/$encryptedId"));
      log("URI+++++++++++++++++++++++++++++++ ${Uri.parse("https://walletconnect.blizerpay.com/$encryptedId")}");
    } catch (e) {
      print(" $e");
    }
  }

  String encodeId(String id) {log("id------> $id");
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    final dataToEncode = '$id|$timestamp';

    String base64 = base64Encode(utf8.encode(dataToEncode));
    return base64.replaceAll('+', '-').replaceAll('/', '_');
  }
}
