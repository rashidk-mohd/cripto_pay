import 'package:blizerpay/common/widgets/text_widgets.dart';
import 'package:blizerpay/constents/path_constents.dart';
import 'package:blizerpay/features/bottom_navigation/home/repository/home_repository.dart';
import 'package:blizerpay/features/message/screens/message_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

final homeProvider = Provider<HomeRepository>(
  (ref) {
    return HomeRepository();
  },
);
final personalDetails = FutureProvider<Map<String, dynamic>>(
  (ref) {
    final homeprovider = ref.watch(homeProvider);
    return homeprovider.getPersonalDetailes();
  },
);

class AppBarBackGroundWidget extends StatelessWidget {
  const AppBarBackGroundWidget(
      {super.key,
      required this.scaffoldKey,
      required this.name,
      required this.balance});
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String? name;
  final String? balance;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: const Color(0xff0E355D),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppBar(
            backgroundColor: const Color(0xff0E355D),
            automaticallyImplyLeading: false,
            centerTitle: true,
            elevation: 0,
            leading: InkWell(
              onTap: () {
                scaffoldKey.currentState?.openDrawer();
              },
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      SvgPicture.asset(PathConstents.drawerIcon),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MessageScreen(),
                                ));
                          },
                          child: SvgPicture.asset(PathConstents.bellIcon)),
                      const SizedBox(
                        width: 30,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Consumer(
              builder: (context, ref, child) {
                final detailsValue = ref.watch(personalDetails);
                return detailsValue.when(
                  data: (data) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DmSansFontText(
                              text: "$name,",
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const DmSansFontText(
                              text: "Your available wallet",
                              fontSize: 15.5,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(PathConstents.blizer),
                            Column(
                              children: [
                                SizedBox(height: 5,),
                                DmSansFontText(
                                  text: balance,
                                  fontSize: 27.07,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                  error: (error, stackTrace) {
                    return const Center(
                      child: DmSansFontText(
                        text: "Error fetching data",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    );
                  },
                  loading: () {
                    return const SizedBox();
                  },
                );
              },
            ),
          ),
          // const SizedBox(height: 10),
        ],
      ),
    );
  }

  bool isNull(Map response) {
    return response.containsKey("error");
  }
}
