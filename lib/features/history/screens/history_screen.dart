import 'dart:developer';
import 'package:blizerpay/features/history/controllers/history_controller.dart';
import 'package:blizerpay/features/history/repository/history_repository.dart';
import 'package:blizerpay/features/history/widgets/history_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final historyProvider = Provider<HistoryRepository>((ref) {
  return HistoryRepository();
});
final walletHistoryNotifier = FutureProvider<List<dynamic>>(
  (ref) async {
    final providerData = ref.watch(historyProvider);
    List<dynamic> responseData = await providerData.getWalletHistory();
    log("responseresponse ==> $responseData");
    return responseData;
  },
);
final consumerNotifier=ChangeNotifierProvider((ref) {
  return HistorController();
},);
class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenConsumerState();
}

class _HistoryScreenConsumerState extends ConsumerState<HistoryScreen> {
  @override
  void initState() {
    ref.read(consumerNotifier.notifier).getWalletHistory();
    super.initState();
  }
  @override
  Widget build(BuildContext context, ) {
    final walletHistoryAsyncValue = ref.watch(walletHistoryNotifier);
    final walletHistoryAsyncValue2 = ref.watch(consumerNotifier);
    return walletHistoryAsyncValue.when(
        data: (history) {
          // Map historyData = {};

          // if (history.isNotEmpty) {
          //   historyData = history[0] as Map;
          // }

          // log("lengthlength ${historyData}");
          return PopScope(
            child: Scaffold(
                appBar: AppBar(
                    leading: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          // history.clear();
                        },
                        child: const Icon(Icons.arrow_back)),
                    title: const Text(
                      "History",
                    )),
                body: walletHistoryAsyncValue2.history.isEmpty
                    ? const Center(
                        child: Text("No Transaction yet"),
                      )
                    :walletHistoryAsyncValue2.isLoading?Center(child: CircularProgressIndicator()): ListView.builder(
                        itemCount: walletHistoryAsyncValue2.history.length - 1,
                        itemBuilder: (context, index) {
                          log("transaction dat ${convertDataFormate(
                            "${walletHistoryAsyncValue2.history[index]["transactionDate"]}",
                          )}");
                          int amount = walletHistoryAsyncValue2.history[index]["amount"];
                          return HistoryWidget(
                            history: walletHistoryAsyncValue2.history,
                            subDate: convertDataFormate(
                                      "${walletHistoryAsyncValue2.history[index]["transactionDate"]}",
                                    ),
                            name: walletHistoryAsyncValue2.history[index]["toWhom"]["name"]
                                .toString()[0]
                                .toUpperCase(),
                            paymentType:
                                walletHistoryAsyncValue2.history[index]["typeOfTransation"] == "w2w"
                                    ? "Wallet to Wallet"
                                    : history[index]["typeOfTransation"],
                            rate: amount.toDouble(),
                            date:index==0?convertDataFormate(
                                    "${walletHistoryAsyncValue2.history[0]["transactionDate"]}",
                                  ):  convertDataFormate(
                                      "${walletHistoryAsyncValue2.history[index]["transactionDate"]}",
                                    ) !=
                                    convertDataFormate(
                                      "${walletHistoryAsyncValue2.history[index - 1]["transactionDate"]}",
                                    )
                                ? convertDataFormate(
                                    "${walletHistoryAsyncValue2.history[index]["transactionDate"]}",
                                  )
                                : "",
                            index: index,
                            type: walletHistoryAsyncValue2.history[index]["transationType"],
                          );
                        },
                      )),
          );
        },
        error: (error, stackTrace) => const Center(
              child: Text("Something went wrong"),
            ),
        loading: () => const Center(child: CircularProgressIndicator()));
  }

  String convertDataFormate(isoDate) {
    DateTime dateTime = DateTime.parse(isoDate);
    String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);
    return formattedDate;
  }
}
