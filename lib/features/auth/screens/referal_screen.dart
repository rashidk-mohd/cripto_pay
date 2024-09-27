
import 'package:blizerpay/common/widgets/text_widgets.dart';
import 'package:blizerpay/constents/path_constents.dart';
import 'package:blizerpay/features/auth/widgets/referal_option.dart';
import 'package:blizerpay/features/auth/widgets/referal_widget.dart';
import 'package:blizerpay/features/bottom_navigation/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

final personlNotifier = ChangeNotifierProvider<HomeController>(
  (ref) {
    return HomeController();
  },
);

class ReferalScreen extends ConsumerStatefulWidget {
  const ReferalScreen({super.key});

  @override
  ConsumerState<ReferalScreen> createState() => _ReferalScreenConsumerState();
}

class _ReferalScreenConsumerState extends ConsumerState<ReferalScreen> {
  @override
  void initState() {
    ref.read(personlNotifier).getPersonalDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final wtchPersonalDetails = ref.watch(personlNotifier);
    return Scaffold(
      appBar: const ReferalAppBar(),
      body: wtchPersonalDetails.personalDetails.isEmpty
          ? const Center(
              child: Text("Something went wrong"),
            )
          : wtchPersonalDetails.homeIsLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const DmSansFontText(
                        text: "Referral code",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      ReferalWidget(
                        refrelCode: wtchPersonalDetails.personalDetails["data"]
                                ["user"]["referalCode"] ??
                            "",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const DmSansFontText(
                        text: "Do you have any referral code ?",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff717E95),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const DmSansFontText(
                        text: "Radeem Code",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff186AFA),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const ReferalOptionWidgets(
                        subTitle: "\$500",
                        title: "You’ve earned till now",
                        path: PathConstents.diamondicon,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ReferalOptionWidgets(
                        subTitle: "Accepted your referral invite",
                        title:
                            " ${wtchPersonalDetails.personalDetails["data"]["user"]["totalInvites"]} People",
                        path: PathConstents.peopleIcon,
                      ),
                    ],
                  ),
                ),
    );
  }
}

class ReferalAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ReferalAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: const Color(0xff0E355D),
      child: Column(
        children: [
          AppBar(
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            backgroundColor: const Color(0xff0E355D),
            actions: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.asset(
                  PathConstents.referalMenuIcon,
                ),
              ),
            ],
          ),
          SvgPicture.asset(
            PathConstents.referalImageIcon,
          ),
          const DmSansFontText(
              text: "You and you friend will get",
              fontSize: 14,
              fontWeight: FontWeight.w500),
          const DmSansFontText(
              text: "1 Referral =20%",
              fontSize: 20,
              fontWeight: FontWeight.w700),
            const  SizedBox(height: 20,),
              Image.asset(PathConstents.referalstageImage)
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(300.0);
}
