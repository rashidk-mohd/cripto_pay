
import 'package:blizerpay/common/widgets/text_widgets.dart';
import 'package:blizerpay/constents/path_constents.dart';
import 'package:blizerpay/core/local_storage.dart';
import 'package:blizerpay/features/bottom_navigation/home/controller/home_controller.dart';
import 'package:blizerpay/features/bottom_navigation/home/repository/home_repository.dart';
import 'package:blizerpay/features/bottom_navigation/home/widget/drawer_widget.dart';
import 'package:blizerpay/features/bottom_navigation/home/widget/home_appBar.dart';
import 'package:blizerpay/features/bottom_navigation/home/widget/invite_frieand_widget.dart';
import 'package:blizerpay/features/bottom_navigation/home/widget/offer_widget.dart';
import 'package:blizerpay/features/bottom_navigation/home/widget/payment_list_widget.dart';
import 'package:blizerpay/features/digital_card/screens/digital_card_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

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
final homeChangeNotierProvider = ChangeNotifierProvider<HomeController>(
  (ref) {
    return HomeController();
  },
);

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenConsumerState();
}

class _HomeScreenConsumerState extends ConsumerState<HomeScreen> {
  String? userName = "";
  int walletAmount = 0;
  dynamic user;

  @override
  void initState() {
    getInitalData();
    super.initState();
  }

  getInitalData() async {
    userName = await LocalStorage().getUserName();
    ref.read(homeChangeNotierProvider.notifier).getPersonalDetails();
    print("$userName");
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // MediaQuery for screen dimensions
    final screenSize = MediaQuery.of(context).size;
    final detailsValue = ref.watch(homeChangeNotierProvider);

    if (detailsValue.personalDetails.isNotEmpty) {
      user = detailsValue.personalDetails["data"]["user"];
      walletAmount = user["WalletAmount"] as int;
    }

    return PopScope(
       canPop: false,
  onPopInvoked: (didPop) {},
      child: Scaffold(
        key: _scaffoldKey,
        appBar: HomeAppBar(
          scaffoldKey: _scaffoldKey,
          name: detailsValue.personalDetails.isEmpty || detailsValue.homeIsLoading
              ? ""
              : "Hello  ${user["name"] ?? ""}",
          balance:
              detailsValue.personalDetails.isEmpty || detailsValue.homeIsLoading
                  ? "0"
                  : "$walletAmount",
        ),
        drawer: detailsValue.personalDetails.isEmpty || detailsValue.homeIsLoading
            ? const SizedBox()
            : HomeDrawerWidget(
                name: user["name"] ?? "",
                email: user["email"] ?? "",
                imageUrl: user["profilePictureUrl"],
              ),
        body: detailsValue.personalDetails.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  const InviteFriendWidget(),
                  SizedBox(height: screenSize.height * 0.01), // Adjust height
                  const OfferWidget(),
                  SizedBox(height: screenSize.height * 0.02),
                  const PaymentListWidget(),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  DigitalCardScreen(balance:walletAmount.toString() ,),
                            ));
                      },
                      child: Center(
                        child: Stack(children: [
                          Image.asset(PathConstents.digitalCard),
                          Positioned(
                              left: screenSize.width * 0.1,
                              top: screenSize.height * 0.04,
                              child: const DmSansFontText(
                                  text: "Digital card",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700)),
                          Positioned(
                              bottom: screenSize.height * 0.1,
                              left: screenSize.width * 0.1,
                              child: const DmSansFontText(
                                  text: "Get discount for every topup,",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400)),
                          Positioned(
                              bottom: screenSize.height * 0.08,
                              left: screenSize.width * 0.1,
                              child: const DmSansFontText(
                                  text: "transfer and payment",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400)),
                        ]),
                      )),
                  SizedBox(
                    height: screenSize.height * 0.03,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                    ),
                    child: DmSansFontText(
                      text: "Task",
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              height: 60,
                              width: 60,
                              child: CircularProgressIndicator(
                                value: 1, // Progress indicator value
                                backgroundColor: Colors.grey[300],
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Colors.blue),
                                strokeWidth: 12.0,
                              ),
                            ),
                          const  Positioned(
                              left: 13,
                              child: Text(
                                '2 of 2', // Display percentage
                                style:  TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DmSansFontText(
                              text: "Earn more coins ",
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                            DmSansFontText(
                              text: "Complete the tasks  and earn 10724 coin",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  //        Stack(
                  //   alignment: Alignment.center,
                  //   children: [
      
                  //     // Percentage Text
                  //     Center(
                  //       child: Text(
                  //         '${(.89 * 100).toStringAsFixed(0)}%', // Display percentage
                  //         style: const TextStyle(
                  //           fontSize: 24,
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.black,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
      
                  //  CircularProgressIndicator()
                  SizedBox(
                    height: 300, // Fixed height for the inner ListView
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: task.length,
                        itemBuilder: (context, index) {
                          return  Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: ChainWidget(
                              head:task[index].head ,
                              subHead: task[index].head,
                              path: task[index].path,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
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

class ChainWidget extends StatelessWidget {
  const ChainWidget({super.key,this.head,this.subHead,this.path});
final String? head;
final String? subHead;final String? path;
  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenSize = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Column(
              children: [
                Container(
                  height: screenSize.height * 0.05, // Adjust height
                  width: screenSize.width * 0.005, // Adjust width
                  color: const Color(0xff007AFF),
                ),
                Container(
                  width: screenSize.width * 0.12, // Circle diameter
                  height: screenSize.width * 0.12, // Circle diameter
                  decoration: BoxDecoration(
                    color: Colors.blue[900],
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: screenSize.width * 0.08), // Adjust spacing
            Column(
              children: [
                SizedBox(height: screenSize.height * 0.05), // Adjust height
                 TaskContainer(path:path!,),
              ],
            ),
            const SizedBox(width: 10),
             Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              const  SizedBox(height: 30),
                DmSansFontText(
                  text: head!,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                DmSansFontText(
                  text: subHead,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}

class TaskContainer extends StatelessWidget {
  const TaskContainer({super.key,this.path});
  final String? path;

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width * 0.12, // Width as a percentage of screen width
      height:
          screenSize.height * 0.06, // Height as a percentage of screen height
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7), // Radius in pixels
        gradient: const LinearGradient(
          colors: [
            Color(0xFF15508D), // Start color
            Color(0xFF1D6FC3), // End color
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Image.asset(path!),
    );
  }
}
class Task {
  String? head;
  String? subHead;
  String? path;
  Task({required this.head,required this.path,required this.subHead});
}
List<Task>task=[
  Task(head: "Join Telegram", path: PathConstents.telegram, subHead: "Be part of our community and join now."),
  Task(head: "Follow us on X", path: PathConstents.x, subHead: "Let’s keep in touch,follow us on X.")
];