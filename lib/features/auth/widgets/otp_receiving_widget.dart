
import 'package:blizerpay/features/auth/controller/auth_controller.dart';
import 'package:blizerpay/features/auth/controller/forgot_password_notifier.dart';
import 'package:blizerpay/features/auth/controller/signup_notifier.dart';
import 'package:blizerpay/features/auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OtpReceivingWidget extends StatelessWidget {
  const OtpReceivingWidget(
      {super.key,
      required this.value,
      this.focusNode,
      this.controller,
      this.onChanged});
  final int? value;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 54,
      decoration: BoxDecoration(
          color: const Color(0xffD9D9D9),
          borderRadius: BorderRadius.circular(8)),
      child: Center(
        child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            style: const TextStyle(fontSize: 24),
            decoration: InputDecoration(
              counterText: '',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onChanged: onChanged),
      ),
    );
  }
}

final otpnotifier = ChangeNotifierProvider(
  (ref) {
    return AuthController();
  },
);
final verificationNotifier =
    StateNotifierProvider<SignUpVerificationNotifier, bool>(
  (ref) {
    AuthenticationRepository authenticationRepository =
        AuthenticationRepository();
    return SignUpVerificationNotifier(authenticationRepository);
  },
);
final verificationNotifierForgot =
    StateNotifierProvider<VerifyForgotPasswordNotifier, bool>(
  (ref) {
    AuthenticationRepository authenticationRepository =
        AuthenticationRepository();
    return VerifyForgotPasswordNotifier(authenticationRepository);
  },
);

// ignore: must_be_immutable
class OtpInput extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final bool first;
  final bool last;
  final List<TextEditingController> controllers;
  bool isForgot = false;

  OtpInput({
    super.key,
    required this.controller,
    required this.first,
    required this.last,
    required this.controllers,
    required this.isForgot,
  });

  @override
  _OtpInputState createState() => _OtpInputState();
}

class _OtpInputState extends ConsumerState<OtpInput> {
  late FocusNode _focusNode;
  // ignore: unused_field
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 65,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: TextField(
        focusNode: _focusNode, // Attach the FocusNode
        controller: widget.controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: Colors.grey.withOpacity(0.3), // Dynamic fill color
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                const BorderSide(color: Colors.white), // Unfocused border color
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (!widget.last) {
              FocusScope.of(context).nextFocus();
            }

            if (_allFieldsFilled()) {
              String otp = getOtpFromControllers();
              _submitOtp(context, ref, otp, widget.isForgot);
            }
          } else {
            if (!widget.first) {
              FocusScope.of(context).previousFocus();
            }
          }
        },
      ),
    );
  }

  bool _allFieldsFilled() {
    return widget.controllers.every((controller) => controller.text.isNotEmpty);
  }

  String getOtpFromControllers() {
    return widget.controllers.map((controller) => controller.text).join();
  }

  void _submitOtp(
      BuildContext context, WidgetRef ref, String otp, bool? isFromForgot) {
    if (isFromForgot == false) {
      ref
          .read(verificationNotifier.notifier)
          .verifSignUpyOtp(context, otp: otp);
    } else {
      print("object $otp");
      ref
          .read(verificationNotifierForgot.notifier)
          .verifyForgotPassword(otp, context);
    }
  }
}
