import 'dart:convert';

import 'package:blizerpay/common/widgets/text_widgets.dart';
import 'package:blizerpay/constents/path_constents.dart';
import 'package:blizerpay/core/local_storage.dart';
import 'package:blizerpay/features/bottom_navigation/home/screens/home_screen.dart';
import 'package:blizerpay/features/bottom_navigation/home/widget/wallet_widget.dart';
import 'package:blizerpay/features/comming_soon.dart';
import 'package:blizerpay/features/history/screens/history_screen.dart';
import 'package:blizerpay/features/history/widgets/history_widget.dart';
import 'package:blizerpay/features/wallet/widget/qrmodel_bottomsheet.dart';
import 'package:blizerpay/features/wallet/widget/walletpayment_option_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class WalletScreen extends ConsumerStatefulWidget {
  const WalletScreen({super.key});

  @override
  ConsumerState<WalletScreen> createState() => _WalletScreenConsumerState();
}

class _WalletScreenConsumerState extends ConsumerState<WalletScreen> {
  TextEditingController walletIdController = TextEditingController();
  TextEditingController walletAmountController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? walletNumber;

  @override
  void initState() {
    getWalletNumber();
    super.initState();
  }

  getWalletNumber() async {
    setState(() async {
      walletNumber = await LocalStorage().getWalletNumber();
      await ref.read(homeChangeNotierProvider.notifier).getPersonalDetails();
      await ref.read(consumerNotifier.notifier).getWalletHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final walletHistoryAsyncValue = ref.watch(walletHistoryNotifier);
    final home = ref.watch(homeChangeNotierProvider);
    final walletHistoryAsyncValue2 = ref.watch(consumerNotifier);

    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Wallet"),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: screenWidth * 0.08),
            child: SvgPicture.asset(
              PathConstents.referalMenuIcon,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          walletHistoryAsyncValue.when(
            data: (data) => Padding(
              padding: EdgeInsets.all(screenWidth * 0.02),
              child: Stack(
                children: [
                  Image.asset(
                    PathConstents.black,
                    width: screenWidth, // Responsive width
                    fit: BoxFit.cover, // Ensure it covers the entire width
                  ),
                  Positioned(
                    top: screenHeight * 0.1, // 10% from the top
                    left: screenWidth * 0.05, // 5% from the left
                    child: InkWell(
                      onTap: () {
                        Clipboard.setData(
                          ClipboardData(text: "$walletNumber"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Copied!")),
                        );
                      },
                      child: Row(
                        children: [
                          DmSansFontText(
                            text: walletNumber,
                            fontSize: screenWidth * 0.06, // Responsive font size
                            fontWeight: FontWeight.w700,
                          ),
                          SizedBox(
                            width: screenWidth * 0.05, // Responsive spacing
                          ),
                          InkWell(
                            onTap: () {
                              Clipboard.setData(
                                ClipboardData(text: "$walletNumber"),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Copied!")),
                              );
                            },
                            child: const DmSansFontText(
                              text: "copy",
                              fontSize: 16, // Static text size if preferred
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: screenHeight * 0.05, // 5% from the bottom
                    left: screenWidth * 0.05, // 5% from the left
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DmSansFontText(
                          text: "Current balance",
                          fontSize: screenWidth * 0.03, // Responsive small font
                          color: Colors.grey.withOpacity(0.6),
                          fontWeight: FontWeight.w700,
                        ),
                        Row(
                          children: [
                            Image.asset(PathConstents.blizerrounded),
                            SizedBox(width: 5,),
                            DmSansFontText(
                              text:
                                  "${home.personalDetails["data"]["user"]["WalletAmount"]}",
                              fontSize: screenWidth * 0.05, // Larger font for balance
                              fontWeight: FontWeight.w700,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            error: (error, stackTrace) => const Center(
              child: CircularProgressIndicator(),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.02, // Spacing
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              WalletPaymentOptionWidget(
                path: PathConstents.addIcon,
                onTap: () {
                  encriptionTheIDURL();
                },
                text: "Add",
              ),
              Column(
                children: [
                  SizedBox(height:20),
                  WalletPaymentOptionWidget(
                    path: PathConstents.withdrawIcon,
                    text: "Wallet to\n  wallet",
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => WalletPaymentWidget(
                          amount: home.personalDetails["data"]["user"]
                                  ["WalletAmount"]
                              .toString(),
                          formKey: formKey,
                          walletAmountController: walletAmountController,
                          walletIdController: walletIdController,
                        ),
                      );
                    },
                  ),
                ],
              ),
              WalletPaymentOptionWidget(
                path: PathConstents.withdrawIcon,
                text: "Withdraw",
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CommingSoonScreen(),
                  ));
                },
              ),
              WalletPaymentOptionWidget(
                path: PathConstents.qrcodeIcon,
                text: "QR code",
                onTap: () async {
                  final qrnumber = await LocalStorage().getWalletNumber();
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => QRcodeBottomSheet(
                      qrnumber: qrnumber,
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.03),
          Expanded(
            child: walletHistoryAsyncValue.when(
              data: (history) {
                return walletHistoryAsyncValue2.history.isEmpty
                    ? const Center(child: Text("No History yet"))
                    : walletHistoryAsyncValue2.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: walletHistoryAsyncValue2.history.length,
                            itemBuilder: (context, index) {
                              int amount = walletHistoryAsyncValue2.history[index]["amount"];
                              String name = walletHistoryAsyncValue2.history[index]["byWhom"]["name"];
                              return HistoryWidget(
                                history: walletHistoryAsyncValue2.history,
                                subDate: convertDataFormate("${walletHistoryAsyncValue2.history[index]["transactionDate"]}"),
                                name: walletHistoryAsyncValue2.history[index]["User"].toString()[0].toUpperCase(),
                                paymentType: walletHistoryAsyncValue2.history[index]["typeOfTransation"] == "w2w"
                                    ? "Wallet to Wallet"
                                    : walletHistoryAsyncValue2.history[index]["typeOfTransation"],
                                rate: amount.toDouble(),
                                date: index == 0
                                    ? convertDataFormate("${walletHistoryAsyncValue2.history[0]["transactionDate"]}")
                                    : convertDataFormate("${walletHistoryAsyncValue2.history[index]["transactionDate"]}") !=
                                            convertDataFormate("${walletHistoryAsyncValue2.history[index - 1]["transactionDate"]}")
                                        ? convertDataFormate("${walletHistoryAsyncValue2.history[index]["transactionDate"]}")
                                        : "",
                                index: index,
                                type: walletHistoryAsyncValue2.history[index]["transationType"],
                              );
                            },
                          );
              },
              error: (error, stackTrace) => const Center(
                child: Text("Something went wrong"),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }

  Future encriptionTheIDURL() async {
    try {
      String? encryptedId;
      String? id = await LocalStorage().getUserID();
      encryptedId = encodeId(id!);
      launchUrl(Uri.parse("https://walletconnect.blizerpay.com/$encryptedId"));
    } catch (e) {
      print(" $e");
    }
  }

  String encodeId(String id) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final dataToEncode = '$id|$timestamp';
    String base64 = base64Encode(utf8.encode(dataToEncode));
    return base64.replaceAll('+', '-').replaceAll('/', '_');
  }

  String convertDataFormate(isoDate) {
    DateTime dateTime = DateTime.parse(isoDate);
    return DateFormat('dd MMM yyyy').format(dateTime);
  }
}
