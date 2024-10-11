import 'dart:developer';
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
          Container(
            padding:const EdgeInsets.all(16.0),
          color: Colors.white,
            child: QrImageView(
                 data: qrnumber!,
            version: QrVersions.auto,    
            size: 200.0,                   
            gapless: false,                
            backgroundColor: Colors.white,
            // foregroundColor: Colors.black, 
            errorCorrectionLevel: QrErrorCorrectLevel.H, //
            ),
          ),
          const SizedBox(height: 20),
          Row( 
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              QRRightButton(
                text: "Open scanner",
                color: Colors.white,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => QRScannerScreen(),
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
            ],
          ),
        ],
      ),
    );
  }

  
}
Future<void> _shareQRImage(String? qr) async {
  log("Generating and sharing QR code...");
  
  // Ensure the QR data is valid
  if (qr == null || qr.isEmpty) {
    log('QR data is empty or null');
    return;
  }

  try {
    // Generate QR code with improved settings
    final image = await QrPainter(
      data: qr,
      version: QrVersions.auto,
      gapless: false,
      color: Colors.white,                    // Set foreground color to black
      emptyColor: Colors.black,               // Set background color to white
      errorCorrectionLevel: QrErrorCorrectLevel.H, 

    ).toImageData(800.0); // Increase the size for better clarity

    if (image == null) {
      log('Failed to generate QR image');
      return;
    }

    // Define file name and location
    String filename = 'qr_code.png';
    final tempDir = await getTemporaryDirectory(); // Get temporary directory
    final file = await File('${tempDir.path}/$filename').create(); // Create file

    // Convert image to bytes and write to file
    final bytes = image.buffer.asUint8List();
    await file.writeAsBytes(bytes); // Write image bytes to file

    log('QR image generated and saved at: ${file.path}');

    // Share the generated QR code
    await Share.shareXFiles(
      [XFile(file.path)],
      text: 'Your wallet number is $qr', // Text message for the share
      subject: 'QR Code',
    );
  } catch (e) {
    log('Error generating or sharing QR code: $e');
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
