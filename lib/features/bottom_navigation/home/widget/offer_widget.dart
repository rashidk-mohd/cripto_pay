
import 'package:blizerpay/constents/path_constents.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OfferWidget extends StatefulWidget {
  const OfferWidget({super.key});

  @override
  State<OfferWidget> createState() => _OfferWidgetState();
}

class _OfferWidgetState extends State<OfferWidget> {
  final pageviewController =
      PageController(viewportFraction: 0.8, keepPage: true,initialPage: 3);
  List<Widget> offerWidgetList = [
    Image.asset(
      PathConstents.offercard,
      height: 250,
    ),
    Image.asset(
      PathConstents.offercard,
      height: 250,
    ),
    Image.asset(
      PathConstents.offercard,
      height: 250,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 140,
          child: PageView.builder(
            onPageChanged: (value) {
              setState(() {
                offerWidgetList.add(Image.asset(
                  PathConstents.offercard,
                  height: 220,
                ));
              });
            },
            controller: pageviewController,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(right: 2),
              child: Center(
                  child: offerWidgetList[index]),
            ),
            itemCount: offerWidgetList.length,
          ),
        ),
        const SizedBox(height: 5),
        SmoothPageIndicator(
          controller: pageviewController,

          count: 3,
          effect: const ExpandingDotsEffect(
            
            dotHeight: 6,
            dotWidth: 6,
            // type: WormType.thinUnderground,
          )
          
        ),
      ],
    );
  }
}
