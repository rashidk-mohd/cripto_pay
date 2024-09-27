
import 'package:blizerpay/common/widgets/blizerfi_custom_button.dart';
import 'package:blizerpay/common/widgets/blizerfi_textform_field_flutter.dart';
import 'package:blizerpay/common/widgets/text_widgets.dart';
import 'package:blizerpay/constents/path_constents.dart';
import 'package:blizerpay/features/auth/controller/forgot_password_notifier.dart';
import 'package:blizerpay/features/auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

final forgotNotifier = StateNotifierProvider<SendOtpToMailNotifier, bool>(
  (ref) {
    final authRepository = AuthenticationRepository();
    return SendOtpToMailNotifier(authRepository);
  },
);

// ignore: must_be_immutable
class ChangePasswordScreen extends ConsumerWidget {
  ChangePasswordScreen({super.key});
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifierValue = ref.watch(forgotNotifier);
    return Scaffold(
      appBar: AppBar(
        actions: [SvgPicture.asset(PathConstents.referalMenuIcon)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          const  Padding(
              padding:  EdgeInsets.only(top: 60),
              child:  DmSansFontText(
                text: "Change password",
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
           const SizedBox(height: 30,),
            const DmSansFontText(
              text: "Enter the email associated with your account",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            const DmSansFontText(
              text: "and we’ll send an email with instructions to ",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            const DmSansFontText(
              text: "change  your password",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
             const SizedBox(height: 30,),
            const DmSansFontText(
              text: "Email address",
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
             const SizedBox(height: 10,),
            BlizerfiCustomTextFormField(
              controller: emailController,
              hitText: "Enter your email",
              validator: (p0) {},
            ),
            const SizedBox(
              height: 20,
            ),
            notifierValue
                ? const CircularProgressIndicator()
                : BlizerfiCustomButton(
                    onPressed: () {
                      // ref
                      //     .read(forgotNotifier.notifier)
                      //     .sendOtpTomail(emailController.text, context);
                    },
                    borderRadius: 20,
                    text: "Send Instruction",
                  )
          ],
        ),
      ),
    );
  }
}
