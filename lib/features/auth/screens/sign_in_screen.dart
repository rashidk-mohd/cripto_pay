
import 'package:blizerpay/common/widgets/blizerfi_custom_button.dart';
import 'package:blizerpay/common/widgets/blizerfi_textform_field_flutter.dart';
import 'package:blizerpay/common/widgets/text_widgets.dart';
import 'package:blizerpay/constents/path_constents.dart';
import 'package:blizerpay/features/auth/controller/signin_notifier.dart';
import 'package:blizerpay/features/auth/repository/auth_repository.dart';
import 'package:blizerpay/features/auth/screens/sign_up_screen.dart';
import 'package:blizerpay/features/auth/widgets/email_verification_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

final signInNotifierProvider = StateNotifierProvider<SignInNotifier, bool>(
  (ref) {
    final AuthenticationRepository authRepository = AuthenticationRepository();
    return SignInNotifier(authRepository);
  },
);

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenConsumerState();
}

class _SignInScreenConsumerState extends ConsumerState<SignInScreen> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    final signInNotifier = ref.watch(signInNotifierProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formkey,
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 80),
                child: Center(
                  child: DmSansFontText(
                    text: "Login Here",
                    fontSize: 27.95,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff195FAB),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: DmSansFontText(
                  text: "Welcome back you've ",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff2A2A2A),
                ),
              ),
              const Center(
                child: DmSansFontText(
                  text: "been missed!",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff2A2A2A),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              BlizerfiCustomTextFormField(
                controller: emailcontroller,
                hitText: "Email",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter your email";
                  } else if (!value.contains("@")) {
                    return "Please Enter correct email";
                  } else {
                    return null;
                  }
                },
              ),
              BlizerfiCustomTextFormField(
                controller: passwordController,
                hitText: "Password",
                obscureText: _obscureText,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter your password";
                  } else {
                    return null;
                  }
                },
                suffix: IconButton(
                  icon: _obscureText
                      ? SvgPicture.asset(PathConstents.eyeOpen)
                      : SvgPicture.asset(PathConstents.eyeClosed),
                  onPressed: () {
                    setState(() {
                      _obscureText =
                          !_obscureText; // Toggle password visibility
                    });
                  },
                ),
              ),
             
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      // if (formkey.currentState!.validate()) {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => EmailVerificationWidget(),
                      );
                      // }
                    },
                    child: const DmSansFontText(
                      text: "Forgot password?",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff15508D),
                    ),
                  ),
                ),
              ),
             const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: signInNotifier
                    ? const Center(child: CircularProgressIndicator())
                    : BlizerfiCustomButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            ref.read(signInNotifierProvider.notifier).login(
                                emailcontroller.text.trim(),
                                passwordController.text,
                                context);
                          }
                        },
                        text: "Sign in",
                        size: 16,
                        gradientColor: const [
                          Color(0xff15508D),
                          Color(0xff1D6FC3),
                        ],
                        borderRadius: 10,
                      ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account?",
                    style: const TextStyle(color: Colors.black, fontSize: 14.0),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Register!',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xff15508D),
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpScreen()),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
