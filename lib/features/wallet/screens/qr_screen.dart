import 'dart:io';

import 'package:blizerpay/constents/path_constents.dart';
import 'package:blizerpay/core/local_storage.dart';
import 'package:blizerpay/features/bottom_navigation/home/screens/home_screen.dart';
import 'package:blizerpay/features/bottom_navigation/home/widget/wallet_widget.dart';
import 'package:blizerpay/features/wallet/widget/qrmodel_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

// ignore: must_be_immutable
class QRScannerScreen extends StatefulWidget {
  QRScannerScreen({super.key, this.amount});
  String? amount;

  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  TextEditingController walletIdController = TextEditingController();
  TextEditingController walletAmountController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  MobileScannerController? _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              onTap: () async {
                final qrnumber = await LocalStorage().getWalletNumber();
                showModalBottomSheet(
                  context: context,
                  builder: (context) => QRcodeBottomSheet(qrnumber: qrnumber),
                );
              },
              child: Image.asset(
                PathConstents.barcode,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              onTap: () async {},
              child: SvgPicture.asset(
                PathConstents.referalMenuIcon,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
              controller: MobileScannerController(
                  detectionSpeed: DetectionSpeed.normal),
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  print(barcode.rawValue ?? "No Data found in QR");
                  {
                    if (barcode.displayValue!.isNotEmpty) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ));
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => WalletPaymentWidget(
                                amount: widget.amount,
                                formKey: formKey,
                                walletAmountController: walletAmountController,
                                walletIdController: TextEditingController(
                                    text: barcode.displayValue),
                              ));
                    }
                  }
                }
              }),
          Positioned(
            child: Center(
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent, width: 3),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final XFile? pickedFile =
                        await _picker.pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      setState(() {
                        _imageFile = File(pickedFile.path);
                      });
                      // Handle uploaded image QR processing if needed
                    }
                  },
                  child: const Text('Upload from gallery'),
                ),
                if (_imageFile != null) ...[
                  Image.file(_imageFile!),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
