
import 'package:blizerpay/common/widgets/blizerfi_custom_button.dart';
import 'package:blizerpay/common/widgets/text_widgets.dart';
import 'package:blizerpay/constents/path_constents.dart';
import 'package:blizerpay/features/bottom_navigation/home/repository/home_repository.dart';
import 'package:blizerpay/features/bottom_navigation/home/screens/home_screen.dart';
import 'package:blizerpay/features/bottom_navigation/home/widget/drawer_widget.dart';
import 'package:blizerpay/features/profile.dart/controllers/image_postnotifier.dart';
import 'package:blizerpay/features/profile.dart/controllers/profile_controller.dart';
import 'package:blizerpay/features/profile.dart/repository/profile_repository.dart';
import 'package:blizerpay/features/profile.dart/screens/profile_edit_screen.dart';
import 'package:blizerpay/features/profile.dart/widgets/circle_avathar_widget.dart';
import 'package:blizerpay/features/profile.dart/widgets/image_post_option_widget.dart';
import 'package:blizerpay/features/profile.dart/widgets/profile_detials_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

final profileController = ChangeNotifierProvider<ProfileController>(
  (ref) {
    return ProfileController();
  },
);
final profileNotifier = StateNotifierProvider<ImagePostApi, ApiHandler>(
  (ref) {
    final profileRepository = ProfileRepository();
    final homeRepository = HomeRepository();
    return ImagePostApi(profileRepository, homeRepository);
  },
);

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenConsumerState();
}

class _ProfileScreenConsumerState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    ref.read(profileController.notifier).getPersonalData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileDataController = ref.watch(profileController);

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ));
            },
            child: const Icon(Icons.arrow_back)),
        title: const Text(
          "Profile",
          style: TextStyle(fontSize: 19),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SvgPicture.asset(
              PathConstents.referalMenuIcon,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: profileDataController.personalDataIsLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer(
                    builder: (context, ref, child) {
                      return CircularAvatarWithBorderWidget(
                        file: profileDataController.personalData["data"]["user"]
                                ["profilePictureUrl"] ??
                            "",
                        onTap: () {},
                        avatarRadius: 50,
                        borderColor: profileDataController.personalData["data"]
                                    ["user"]["profilePictureUrl"] ==
                                null
                            ? Colors.white
                            : Colors.black,
                        borderWidth: 4,
                        onEditTap: () {
                          showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (context) => const ImagePostOptionWidget(),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: DmSansFontText(
                      text: profileDataController.personalData["data"]["user"]
                                  ["name"] ==
                              null
                          ? ""
                          : "${profileDataController.personalData["data"]["user"]["name"]}",
                      fontSize: 13.3,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff2A2A2A),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: DmSansFontText(
                      text:
                          "${profileDataController.personalData["data"]["joined"]}",
                      fontSize: 11.4,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff2A2A2A),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      height: 40,
                      child: BlizerfiCustomButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfileEditScreen(
                                  name: profileDataController
                                      .personalData["data"]["user"]["name"],
                                  email:
                                      "${profileDataController.personalData["data"]["user"]["email"]}",
                                ),
                              ));
                        },
                        text: "Edit Profile",
                        size: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ProfileDetaileWidget(
                    path: PathConstents.profileIcon,
                    title: "Full Name",
                    subtitle:
                        "${profileDataController.personalData["data"]["user"]["name"]}",
                    isLogOut: false,
                  ),
                  // const Divider(
                  //   thickness: 2,
                  //   color: Color(0xffEDEFF6),
                  //   endIndent: 20,
                  //   indent: 20,
                  // ),()
                  const Divider(
                    thickness: 2,
                    color: Color(0xffEDEFF6),
                    endIndent: 20,
                    indent: 20,
                  ),
                  ProfileDetaileWidget(
                    path: PathConstents.helpIcon,
                    title: "Email",
                    subtitle:
                        "${profileDataController.personalData["data"]["user"]["email"]}",
                    isLogOut: false,
                  ),
                  const Divider(
                    thickness: 2,
                    color: Color(0xffEDEFF6),
                    endIndent: 20,
                    indent: 20,
                  ),
                  InkWell(
                    onTap: () {
                      showSignoutDialog(context, ref);
                    },
                    child: ProfileDetaileWidget(
                      path: PathConstents.logoutIcon,
                      title: "",
                      subtitle: "Log out",
                      isLogOut: true,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

void showSignoutDialog(BuildContext context, WidgetRef ref) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.all(30),
        title: Align(
          alignment: Alignment.topLeft,
          child: Image.asset(PathConstents.logOut),
        ),
        content: Column(
          mainAxisSize: MainAxisSize
              .min, 
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Logout from Blizerpay',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            const DmSansFontText(
              text:
                  "Are you sure you want to log out of your Blizerpay account?",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffDDDDDD),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8), 
                      ),
                    ),
                    child: const DmSansFontText(
                      text: "Cancel",
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff000080),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: BlizerfiCustomButton(
                      size: 12,
                      fontWeight: FontWeight.w600,
                      borderRadius: 8,
                      onPressed: () {
                        ref.read(authController.notifier).logOut(context);
                      },
                      text: "Logout",
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
