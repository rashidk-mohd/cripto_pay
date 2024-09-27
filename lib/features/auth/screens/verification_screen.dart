
import 'package:blizerpay/common/widgets/text_widgets.dart';
import 'package:blizerpay/features/auth/controller/forgot_password_notifier.dart';
import 'package:blizerpay/features/auth/controller/signup_notifier.dart';
import 'package:blizerpay/features/auth/repository/auth_repository.dart';
import 'package:blizerpay/features/auth/screens/change_password_screen.dart';
import 'package:blizerpay/features/auth/widgets/otp_receiving_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final verificationNotifier =
    StateNotifierProvider<SignUpVerificationNotifier, bool>(
  (ref) {
    AuthenticationRepository authenticationRepository =
        AuthenticationRepository();
    return SignUpVerificationNotifier(authenticationRepository);
  },
);
final forgotVerification =
    StateNotifierProvider<VerifyForgotPasswordNotifier, bool>(
  (ref) {
    AuthenticationRepository authenticationRepository =
        AuthenticationRepository();
    return VerifyForgotPasswordNotifier(authenticationRepository);
  },
);

// ignore: must_be_immutable
class VerificationScreen extends ConsumerStatefulWidget {
  VerificationScreen({super.key, required this.isFromForgot,required this.email});
  bool isFromForgot = true;
  String? email;
  @override
  ConsumerState<VerificationScreen> createState() =>
      _VerificationScreenConsumerState();
}

class _VerificationScreenConsumerState
    extends ConsumerState<VerificationScreen> {
  final otpControllers = List<TextEditingController>.generate(
      4, (index) => TextEditingController(text: ""));

  // Focus nodes for each input field
  final otpFocusNodes = List<FocusNode>.generate(4, (index) => FocusNode());

  @override
  Widget build(BuildContext context) {
    final verifyNotifier = ref.watch(verificationNotifier);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const DmSansFontText(
              text: "Verification",
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color(0xff2A2A2A)),
             const SizedBox(height: 20,),
          const DmSansFontText(
              text: "Verify the email by entering the verification",
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xff797395)),
          const DmSansFontText(
              text: "code",
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xff797395)),
          const SizedBox(height: 20),
          const DmSansFontText(
              text: "Didn’t receive verification code?",
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xff2A2A2A)),
             const SizedBox(height: 20,),
          InkWell(
            onTap: () {
               ref
                                    .read(forgotNotifier.notifier)
                                    .sendOtpTomail(widget.email, context);
            },
            child: const DmSansFontText(
                text: "Resend code",
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xff005CEE)),
          ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: SizedBox(
              height: 50,
              child: verifyNotifier
                  ? const SizedBox()
                  : Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < otpControllers.length; i++)
                          OtpInput(
                            isForgot:widget.isFromForgot ,
                            controller: otpControllers[i],
                            first: i == 0,
                            last: i == otpControllers.length - 1,
                            controllers: otpControllers,
                          ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
