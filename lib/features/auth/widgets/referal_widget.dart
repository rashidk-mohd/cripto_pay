
import 'package:blizerpay/common/widgets/text_widgets.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ReferalWidget extends StatelessWidget {
  const ReferalWidget({super.key, required this.refrelCode});
  final String? refrelCode;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(2),
            dashPattern: const [20, 10],
            color: Colors.yellow,
            strokeWidth: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DmSansFontText(
                      text: refrelCode,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    )),
                GestureDetector(
                  onTap: () {
                    shareReferal(refrelCode);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Share",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  void shareReferal(String? referal) async {
    try {
      await Share.shareUri(
          Uri.parse('https://register.blizerpay.com/signup/$referal'));
    } catch (e) {
      print('Error sharing image: $e');
    }
  }
}
