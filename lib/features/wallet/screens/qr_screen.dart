import 'dart:developer';
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
  // ignore: library_private_types_in_public_api
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  TextEditingController walletIdController = TextEditingController();
  TextEditingController walletAmountController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  MobileScannerController cameraController = MobileScannerController();

  BarcodeCapture? _barcodeCapture;

  Future<void> _analyzeImageFromFile() async {
    try {
      final XFile? file = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
        maxWidth: 1080,
        maxHeight: 1080,
      );

      final fileData = file?.path;
      log("fileDatafileData $fileData");
      final BarcodeCapture? barcodeCapture = 
          await cameraController.analyzeImage(fileData!);

      if (mounted) {
        setState(() {
          _barcodeCapture = barcodeCapture;
        });
      }

      log("QR code detected: ${_barcodeCapture!.barcodes}");
    } catch (e) {
      log("Error while analyzing the QR code image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_barcodeCapture != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        for (final barcode in _barcodeCapture!.barcodes) {
          {
            if (barcode.displayValue!.isNotEmpty) {
              showModalBottomSheet(
                  context: context,
                  builder: (context) => WalletPaymentWidget(
                        amount: widget.amount,
                        formKey: formKey,
                        walletAmountController: walletAmountController,
                        walletIdController:
                            TextEditingController(text: barcode.displayValue),
                      ));
            }
          }
        }
      });
    }

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
          // _imageFile == null ? const SizedBox() : Image.file(_imageFile!),

          MobileScanner(
              controller: MobileScannerController(
                  detectionSpeed: DetectionSpeed.normal),
              onDetect: (capture) async {
                final List<Barcode> barcodes = capture.barcodes;
                for (final barcode in barcodes) {
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
                    _analyzeImageFromFile();
                  },
                  child: const Text('Upload from gallery'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Future<void> scanFromGallery() async {
  //   final ImagePicker picker = ImagePicker();
  //   final XFile? image = await picker.pickImage(source: ImageSource.gallery);

  //   if (image != null) {
  //     // Convert XFile to File
  //     setState(() {
  //       _imageFile = File(image.path);
  //     });

  //     // Now you can use the File object (imageFile) for further processing
  //     print('File path: ${_imageFile!.path}');
  //   } else {
  //     print('No image selected');
  //   }
  // }
  // @override
  // void dispose() {
  //   ca?.dispose();
  //   super.dispose();
  // }
}
