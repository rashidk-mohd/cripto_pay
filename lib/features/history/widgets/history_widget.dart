import 'package:blizerpay/common/widgets/text_widgets.dart';
import 'package:blizerpay/constents/path_constents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class HistoryWidget extends StatelessWidget {
  HistoryWidget(
      {super.key,
      required this.name,
      required this.paymentType,
      required this.rate,
      required this.subDate,
      required this.date,
      required this.type,
      this.history,
      required this.index});
  final String? name;
  final String? paymentType;
  final double? rate;
  final String? date;
  final int? index;
  final String? type;
  String? subDate;
  List<dynamic>? history;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (index == 0 ||
                history![index!]["transactionDate"] !=
                    history![index! - 1]["transactionDate"])
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, bottom: 10), // Reduced bottom padding
                child: DmSansFontText(
                  text: date,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff2A2A2A),
                ),
              ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 64,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xffEEF2F8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            name.toString(),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff005CEE),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                          width: 12), // Reduced width between elements
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DmSansFontText(
                            text: paymentType,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff2A2A2A),
                          ),
                          DmSansFontText(
                            text: subDate,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff717E95),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 10), // Reduced padding
                    child: Row(
                      children: [
                        SizedBox(
                            height: 20,
                            width: 20,
                            child: Image.asset("assets/logo/app_logo.png")),
                        const SizedBox(
                          width: 10,
                        ),
                        DmSansFontText(
                          text: "$rate",
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: type == "debit"
                              ? Colors.red
                              : const Color(0xff19B832),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(
              thickness: 1,
              color: Colors.grey.withOpacity(0.2),
            ),
          ],
        ));
  }
}
