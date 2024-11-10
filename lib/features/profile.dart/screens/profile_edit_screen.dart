
import 'package:blizerpay/common/widgets/blizerfi_custom_button.dart';
import 'package:blizerpay/common/widgets/blizerfi_textform_field_flutter.dart';
import 'package:blizerpay/common/widgets/text_widgets.dart';
import 'package:blizerpay/constents/path_constents.dart';
import 'package:blizerpay/features/profile.dart/controllers/profile_notifier.dart';
import 'package:blizerpay/features/profile.dart/repository/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

final editNotifier = StateNotifierProvider<ProfileEditNotifier, bool>(
  (ref) {
    final profileRepository = ProfileRepository();
    return ProfileEditNotifier(profileRepository);
  },
);

class ProfileEditScreen extends ConsumerStatefulWidget {
  const ProfileEditScreen({super.key, this.email, this.name});
  final String? name;
  final String? email;
  @override
  ConsumerState<ProfileEditScreen> createState() =>
      _ProfileEditScreenConsumerState();
}

class _ProfileEditScreenConsumerState extends ConsumerState<ProfileEditScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  void initState() {
    emailController.text = widget.email ?? "";
    userNameController.text = widget.name ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final asycValue = ref.watch(editNotifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
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
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 90),
        child: Form(
          key: formkey,
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: DmSansFontText(
                  text: "Name",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              BlizerfiCustomTextFormField(
                controller: userNameController,
                hitText: "",
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "Name can't be empty";
                  } else if (p0.length > 18) {
                    return "Maximum character limit is 18";
                  }
                  return null;
                },
              ),
              // const Padding(
              //   padding: EdgeInsets.all(8.0),
              //   child: DmSansFontText(
              //     text: "Email",
              //     fontSize: 14,
              //     fontWeight: FontWeight.w400,
              //     color: Colors.black,
              //   ),
              // ),
              // BlizerfiCustomTextFormField(
              //   controller: emailController,
              //   hitText: "",
              // ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: asycValue
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : BlizerfiCustomButton(
                        borderRadius: 15,
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            ref.read(editNotifier.notifier).editProfile(
                                emailController.text,
                                userNameController.text,
                                context);
                          }
                        },
                        text: "Save",
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
