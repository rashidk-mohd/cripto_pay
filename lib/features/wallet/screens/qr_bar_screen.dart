
import 'package:blizerpay/features/wallet/screens/qr_screen.dart';
import 'package:blizerpay/features/wallet/widget/qrmodel_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRBarScreen extends StatelessWidget {
  const QRBarScreen({super.key, this.qrnumber});
  final String? qrnumber;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // QR Code
              QrImageView(
                data: qrnumber!, // Your 16-digit number
                version: QrVersions.auto,
                size: 200.0,
              ),
              const SizedBox(height: 80), // Spacing between QR code and buttons
              // Row of Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  QRRightButton(
                    text: "QR Scanner",
                    color: Colors.white,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  QRScannerScreen(),
                          ));
                    },
                    gradientColors: const [
                      Color(0xff15508D),
                      Color(0xff1D6FC3),
                    ],
                  ),
                  QRRightButton(
                    text: "Share QR code",
                    color: Colors.black,
                    onTap: () {},
                    gradientColors: const [
                      Colors.white,
                      Colors.white,
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
