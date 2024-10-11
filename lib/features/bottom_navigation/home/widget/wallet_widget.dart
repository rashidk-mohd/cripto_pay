import 'dart:developer';
import 'package:blizerpay/common/widgets/blizerfi_custom_button.dart';
import 'package:blizerpay/common/widgets/blizerfi_textform_field_flutter.dart';
import 'package:blizerpay/common/widgets/text_widgets.dart';
import 'package:blizerpay/constents/path_constents.dart';
import 'package:blizerpay/core/local_storage.dart';
import 'package:blizerpay/features/bottom_navigation/home/controller/wallet_to_wallet_notifier.dart';
import 'package:blizerpay/features/bottom_navigation/home/repository/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

final walletNotifier = StateNotifierProvider<WalletToWalletNotifier, bool>(
  (ref) {
    final HomeRepository homerepository = HomeRepository();
    return WalletToWalletNotifier(homerepository);
  },
);

// ignore: must_be_immutable
class WalletPaymentWidget extends StatelessWidget {
   WalletPaymentWidget(
      {super.key,
      required this.walletIdController,
      this.amount,
      required this.formKey,
      required this.walletAmountController});
  final TextEditingController walletIdController;
  final TextEditingController walletAmountController;
  final GlobalKey<FormState> formKey;
  String? amount;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const DmSansFontText(
              text: "Set amount",
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xff2A2A2A),
            ),
            const SizedBox(
              height: 10,
            ),
            const DmSansFontText(
              text: "Please enter the amount you wish to send",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xff717E95),
            ),
            const SizedBox(
              height: 20,
            ),
            const DmSansFontText(
              text: "Wallet to Wallet",
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xff2A2A2A),
            ),
            const SizedBox(
              height: 20,
            ),
            WalletPaymetTextFields(
              
              amount: amount,
              formKey: formKey,
              walletAmountController: walletAmountController,
              walletIdController: walletIdController,
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class WalletPaymetTextFields extends StatefulWidget {
  WalletPaymetTextFields(
      {super.key,
      required this.walletIdController,
      this.amount,
      required this.formKey,
      required this.walletAmountController});
  TextEditingController walletIdController;
  final TextEditingController walletAmountController;
  final GlobalKey<FormState> formKey;
  String? amount;

  @override
  State<WalletPaymetTextFields> createState() => _WalletPaymetTextFieldsState();
}

class _WalletPaymetTextFieldsState extends State<WalletPaymetTextFields> {
  String? walletNumber;
  String? msg;
  Map postResponse = {};
  @override
  void initState() {
    getwalletNumber();
    super.initState();
  }

  getwalletNumber() async {
    walletNumber = await LocalStorage().getWalletNumber();
    log("walletNumberwalletNumber $walletNumber");
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                "Wallet ID",
                style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff344054)),
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            BlizerfiCustomTextFormField(
              
              controller: widget.walletIdController,
              hitText: "Enter your wallet ID",
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please Enter your value";
                }
                if (walletNumber == value) {
                  return "Unable to send own wallet number";
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                String text =
                    widget.walletIdController.text.replaceAll(' ', '');
                log("text======================> $text"); // Remove existing spaces
                String formattedText = '';
                for (int i = 0; i < text.length; i++) {
                  formattedText += text[i];
                  if ((i + 1) % 4 == 0 && i != text.length - 1) {
                    formattedText += ' '; // Add space after every 4 digits
                  }
                }
                widget.walletIdController.text = formattedText;
              },
              keyBoardtype: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, // Only allows digits
                LengthLimitingTextInputFormatter(16),
              ],
            ),
            const SizedBox(
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                "Wallet Amount",
                style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff344054)),
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            BlizerfiCustomTextFormField(
              keyBoardtype: TextInputType.number,
              
              onChanged: (p0) {},
              controller: widget.walletAmountController,
              hitText: "Enter your Wallet Amount",
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please Enter your value";
                } else if (double.parse(widget.amount!)<double.tryParse(widget.walletAmountController.text)!) {
                  return "insufficient balance";
                } else {
                  return null;
                }
              },
              prefix: SizedBox(
                width: 10,height: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/logo/bliz.png",),
                )),
            ),
            const SizedBox(
              height: 10,
            ),
            Consumer(
              builder: (context, ref, child) {
                final wllaetNotifierWatch = ref.watch(walletNotifier);
                return wllaetNotifierWatch
                    ? const Center(child: CircularProgressIndicator())
                    : BlizerfiCustomButton(
                        backGroundColor: const Color(0xff15508D),
                        borderRadius: 10,
                        onPressed: () async {
                          if (widget.formKey.currentState!.validate()) {
                            Map data = await ref
                                .read(walletNotifier.notifier)
                                .walletTowalltTransfer(
                                    widget.walletIdController.text,
                                    double.tryParse(
                                        widget.walletAmountController.text),
                                    context,
                                    msg);
                            setState(() {
                              postResponse = data;
                            });
                          }
                        },
                        text: "Submit",
                        gradientColor: const [
                          Color(0xff15508D),
                          Color(0xff1D6FC3),
                        ],
                      );
              },
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
