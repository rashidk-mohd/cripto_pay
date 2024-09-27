import 'package:blizerpay/common/widgets/blizerfi_custom_button.dart';
import 'package:blizerpay/common/widgets/blizerfi_textform_field_flutter.dart';
import 'package:blizerpay/common/widgets/text_widgets.dart';
import 'package:blizerpay/constents/path_constents.dart';
import 'package:blizerpay/features/auth/controller/forgot_password_notifier.dart';
import 'package:blizerpay/features/auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

// final forgotNotifier=StateNotifierProvider<SendOtpToMailNotifier,bool>((ref) {
//   final authenticationRepository=AuthenticationRepository();
//   return SendOtpToMailNotifier(authenticationRepository);
// },);
final forgotNotifier = StateNotifierProvider<UpdatePasswordNotifier, bool>(
  (ref) {
    final authenticationRepository = AuthenticationRepository();
    return UpdatePasswordNotifier(authenticationRepository);
  },
);

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenConsumerState();
}

class _ForgotPasswordScreenConsumerState
    extends ConsumerState<ForgotPasswordScreen> {
  bool _confirmPasswordObstrucleText = false;
  bool _obscureText = false;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confiremPassworController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final forgotNotifierValue = ref.watch(forgotNotifier);
    return Scaffold(
      appBar: AppBar(
        title: const DmSansFontText(
            text: "Forgot password",
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: Color(0xff082431)),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SvgPicture.asset(PathConstents.menuIcon),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DmSansFontText(
                    text: "Set a new password",
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff2A2A2A)),
                const SizedBox(
                  height: 30,
                ),
                const DmSansFontText(
                    text: "Create a new password. Ensure it differs from",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff2A2A2A)),
                const DmSansFontText(
                    text: "previous ones for security",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff2A2A2A)),
                const SizedBox(height: 30),
                const DmSansFontText(
                    text: "Password",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff2A2A2A)),
                // const SizedBox(height: 10),
                BlizerfiCustomTextFormField(
                  obscureText: _obscureText,
                  controller: passwordController,
                  lablelTextSize: 17,
                  hitText: "Enter your new password",
                  suffix: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: _obscureText
                        ? SvgPicture.asset(PathConstents.eyeOpen)
                        : SvgPicture.asset(PathConstents.eyeClosed),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter password";
                    }else if (!isPasswordValid(value)) {
                      return 'Password must be at least 8 characters, \ninclude an uppercase letter, a number, and a \nspecial character';
                    } 
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const DmSansFontText(
                    text: " Confirm Password",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff2A2A2A)),
                BlizerfiCustomTextFormField(
                  obscureText: _confirmPasswordObstrucleText,
                  controller: confiremPassworController,
                  lablelTextSize: 17,
                  hitText: "Re-enter password",
                  suffix: IconButton(
                    onPressed: () {
                      setState(() {
                        _confirmPasswordObstrucleText =
                            !_confirmPasswordObstrucleText; // Toggle password visibility
                      });
                    },
                    icon: _confirmPasswordObstrucleText
                        ? SvgPicture.asset(PathConstents.eyeOpen)
                        : SvgPicture.asset(PathConstents.eyeClosed),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter password";
                    } else if (passwordController.text !=
                        confiremPassworController.text) {
                      return "Please Enter your correct password";
                    } else if (passwordController.text !=
                        confiremPassworController.text) {
                      return "Check your password";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                Center(
                  child: forgotNotifierValue
                      ? const CircularProgressIndicator()
                      : BlizerfiCustomButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              ref.read(forgotNotifier.notifier).updatePassword(
                                  context,
                                  password: passwordController.text);
                            }
                          },
                          text: "Update password",
                          gradientColor: const [
                            Color(0xff15508D),
                            Color(0xff1D6FC3),
                          ],
                          borderShapeRadius: 10,
                          borderRadius: 10),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isPasswordValid(String password) {
    String pattern =
        r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$&*~])(?=.*[a-z]).{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }
}
