import 'dart:io';

import 'package:blizerpay/features/wallet/screens/qr_screen.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class QRcodeBottomSheet extends StatelessWidget {
  const QRcodeBottomSheet({super.key, this.qrnumber});
  final String? qrnumber;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // QR Code
          // PrettyQrView.data(data: "1111 1111 1111 1111"),
          QrImageView(
            data: qrnumber!,
            version: QrVersions.auto,
            size: 250.0,
            errorCorrectionLevel: QrErrorCorrectLevel.H,
            foregroundColor: Colors.black, // Set QR code color
            backgroundColor: Colors.white, // Set background color
          ),
          const SizedBox(height: 20), // Spacing between QR code and buttons
          // Row of Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              QRRightButton(
                text: "Open scanner",
                color: Colors.white,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
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
                onTap: () {
                  _shareQRImage("$qrnumber");
                },
                gradientColors: const [
                  Colors.white,
                  Colors.white,
                ],
              ),
              //  const  QRRightButton(),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _shareQRImage(String? qr) async {
    // Ensure the QR data is valid
    if (qr == null || qr.isEmpty) {
      print('QR data is empty or null');
      return;
    }

    try {
      // Generate QR code with higher error correction level
      final image = await QrPainter(
        data: qr,
        version: QrVersions.auto,
        gapless: false,
        color: Colors.black,
        emptyColor: Colors.white,
        errorCorrectionLevel: QrErrorCorrectLevel.H, // High error correction
      ).toImageData(400.0); // Generate QR code image data with increased size

      if (image == null) {
        print('Failed to generate QR image');
        return;
      }

      // Define file name and location
      String filename = 'qr_code.png';
      final tempDir = await getTemporaryDirectory(); // Get temporary directory
      final file =
          await File('${tempDir.path}/$filename').create(); // Create file
      var bytes = image.buffer.asUint8List(); // Get image bytes
      await file.writeAsBytes(bytes); // Write image bytes to file

      // Share the generated QR code
      await Share.shareXFiles(
        [XFile(file.path)],
        text:
            'Your wallet number is $qr', // Ensure this matches your QR code data
        subject: 'QR Code',
      );
    } catch (e) {
      print('Error generating or sharing QR code: $e');
    }
  }
}

class QRRightButton extends StatelessWidget {
  const QRRightButton(
      {super.key, this.onTap, this.gradientColors, this.text, this.color});
  final void Function()? onTap;
  final List<Color>? gradientColors;
  final String? text;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 141,
          height: 44,
          // padding:const EdgeInsets.symmetric(vertical: 9, horizontal: 28),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: gradientColors ?? [],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            border: const Border(
              bottom: BorderSide(
                color: Colors.transparent, // Set your desired color here
                width: 0.5,
              ),
            ),
          ),
          child: Center(
            child: Text(
              text ?? "", // Button text
              style: TextStyle(
                color: color, // Text color
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
