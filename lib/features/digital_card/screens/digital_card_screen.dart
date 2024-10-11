
import 'package:blizerpay/common/widgets/text_widgets.dart';
import 'package:blizerpay/constents/path_constents.dart';
import 'package:blizerpay/core/utils.dart';
import 'package:blizerpay/features/digital_card/controller/digital_notifier.dart';
import 'package:blizerpay/features/digital_card/repository/ditgital_card_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

final digitalNotiffier = StateNotifierProvider<DigitalPostNotifier, bool>(
  (ref) {
    final DigitalCardRepository repo = DigitalCardRepository();
    return DigitalPostNotifier(repo);
  },
);

class DigitalCardScreen extends ConsumerStatefulWidget {
  const DigitalCardScreen({super.key,this.balance});
final String? balance;
  @override
  ConsumerState<DigitalCardScreen> createState() =>
      _DigitalCardScreenConsumerState();
}

class _DigitalCardScreenConsumerState extends ConsumerState<DigitalCardScreen> {
  int _count = 0;
  int total = 0;
  String? _selectedOption = 'Option 1';
  void _increment() {
    setState(() {
      _count++;
      total = 10 * _count;
    });
  }

  void _decrement() {
    setState(() {
      if (_count > 0) {
        _count--;
        total = _count * 10;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final asyncValu = ref.watch(digitalNotiffier);
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const DmSansFontText(
          text: "Digitalcard",
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SvgPicture.asset(
              PathConstents.referalMenuIcon,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30,left: 10,right: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 200.0,
                  height: 100.0,
                  child: Image.asset(PathConstents.digcard),
                ),
                // const SizedBox(width: 16), // Space between image and text
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   const Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DmSansFontText(
                        text: "BlizerPay Digitalcard",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12,right: 8,top: 8,bottom: 8),
                      child: Row(
                        children: [
                          
                          SizedBox(
                              height: 1,
                              width: 1,
                              child: Transform.scale(
                                scale: 0.9,
                                child: Radio<String>(
                                  value: 'Option 1',
                                  activeColor: Colors.black,
                                  groupValue: _selectedOption,
                                  onChanged: (String? value) {
                                    setState(() {
                                      _selectedOption = value;
                                    });
                                  },
                                ),
                              )),
                          const SizedBox(
                            width: 15,
                          ),
                          const DmSansFontText(
                            text: "Blizer Pay store",
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                            color: Color(0xff000000),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ],
            ),
          ),
        const  SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                const DetailsContainer(
                  title: "Card price",
                  subTitle: "20.00",
                  color: Colors.red,
                ),
                const SizedBox(width: 8), // Space between containers
                const DetailsContainer(
                  title: "Offer price",
                  subTitle: "10.00",
                  color: Colors.green,
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 110,
                  height: 70, // Set a fixed width for each detail container
                  // padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white, // Border color
                        width: 1.0, // Border width
                      ),
                      boxShadow: const [
                        BoxShadow(color: Colors.grey, blurRadius: 10)
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 10  ),
                          child: DmSansFontText(
                            text: "Quantity",
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                              onTap: () {
                                _decrement();
                              },
                              child: SvgPicture.asset(PathConstents.minus)),
                          const SizedBox(
                            width: 10,
                          ),
                          DmSansFontText(
                            text: _count.toString(),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                              onTap: () {
                                _increment();
                              },
                              child: SvgPicture.asset(PathConstents.plus)),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 30, right: 20),
            child: DmSansFontText(
              text: "Enjoy 70% Off on Your Purchase! Don't Miss Out on ",
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 30, right: 20),
            child: DmSansFontText(
              text: "This Limited-Time Offer! ",
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
           Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: DmSansFontText(
                    text: "Card price: ",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right:4.0),
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: Image.asset("assets/logo/app_logo.png")),
                      ),
                      const DmSansFontText(
                        text: "20.00 ",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1,
            color: Colors.grey,
            endIndent: 35,
            indent: 40,
          ),
           Padding(
            padding: EdgeInsets.only(top: 10, right: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: DmSansFontText(
                    text: "Blizerpay offer price:",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Row(
                    children: [
                      SizedBox(
                          height: 20,
                          width: 20,
                          child: Image.asset("assets/logo/app_logo.png")),
                      
                     const Padding(
                        padding: const EdgeInsets.only(right:6.0),
                        child: DmSansFontText(
                          text: "10.00 ",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Material(
            elevation: 0.9,
            child: Container(
              width: double.infinity, // Responsive width (375px)
              height: screenHeight * (62 / 812), // Responsive height (62px)
              color: const Color(0xff124678)
                  .withOpacity(0.68), // You can change the color
              // You can add other properties like padding, margin, etc.
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                         DmSansFontText(
                            text: "Total:",
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: Image.asset("assets/logo/app_logo.png")),
                      
                        SizedBox(width: 5,),
                        DmSansFontText(
                            text: "${total.toStringAsFixed(2)}",
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: asyncValu
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              if (total == 0) {
                                Utile.showSnackBarI(context,
                                    "Please purchase your digital card", false);
                              } else if(double.tryParse(widget.balance!)==0){
                                 Utile.showSnackBarI(context,
                                    "Insufficient balance", false);
                              }else {
                                ref
                                    .read(digitalNotiffier.notifier)
                                    .postDigitalCardPurchase(
                                        _count, 10, context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff165596),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Row(
                              children: [
                                DmSansFontText(
                                    text: "Payment",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.arrow_forward, // Arrow icon
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailsContainer extends StatelessWidget {
  const DetailsContainer({super.key, this.title, this.subTitle, this.color});
  final String? title;
  final String? subTitle;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0.9,
      child: Container(
        width: 100,
        height: 70, // Set a fixed width for each detail container
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.white, // Border color
              width: 1.0, // Border width
            ),
            boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 5)]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DmSansFontText(
              text: title,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: color,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                 SizedBox(
                          height: 20,
                          width: 20,
                          child: Image.asset("assets/logo/app_logo.png")),
                      
                const  SizedBox(width: 5,),
                  DmSansFontText(
                    text: subTitle,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
