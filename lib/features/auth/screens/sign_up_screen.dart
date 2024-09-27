import 'package:blizerpay/common/widgets/blizerfi_custom_button.dart';
import 'package:blizerpay/common/widgets/blizerfi_textform_field_flutter.dart';
import 'package:blizerpay/common/widgets/text_widgets.dart';
import 'package:blizerpay/constents/path_constents.dart';
import 'package:blizerpay/features/auth/controller/signup_notifier.dart';
import 'package:blizerpay/features/auth/repository/auth_repository.dart';
import 'package:blizerpay/features/auth/screens/sign_in_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

final apiNotifierProvider = StateNotifierProvider<SignUpNotifiear, bool>((ref) {
  final authRepository = AuthenticationRepository();
  return SignUpNotifiear(authRepository);
});

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenConsumerState();
}

class _SignUpScreenConsumerState extends ConsumerState<SignUpScreen> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final formkey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _confirmPasswordObstrucleText = false;
  @override
  Widget build(BuildContext context) {
    final authNotifier = ref.watch(apiNotifierProvider);
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
                    text: "Create Account",
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
                  text: "Create an account so you can explore all the ",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff2A2A2A),
                ),
              ),
              const Center(
                child: DmSansFontText(
                  text: "existing jobs",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff2A2A2A),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              BlizerfiCustomTextFormField(
                controller: userNameController,
                hitText: "Full name",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter your Full name";
                  } else if (value.length > 18) {
                    return "Maximum character limit is 18";
                  } else {
                    return null;
                  }
                },
              ),
              BlizerfiCustomTextFormField(
                controller: emailcontroller,
                hitText: "Email",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter your Email";
                  } else if (!value.contains("@")) {
                    return "Please Enter correct email";
                  } else {
                    return null;
                  }
                },
              ),
              BlizerfiCustomTextFormField(
                  obscureText: _obscureText,
                  controller: passwordController,
                  hitText: "Password",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter your Password";
                    } else if (!isPasswordValid(value)) {
                      return 'Password must be at least 8 characters, \ninclude an uppercase letter, a number, and a \nspecial character';
                    } else {
                      return null;
                    }
                  },
                  suffix: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: _obscureText
                        ? SvgPicture.asset(PathConstents.eyeOpen)
                        : SvgPicture.asset(PathConstents.eyeClosed),
                  )),
              BlizerfiCustomTextFormField(
                obscureText: _confirmPasswordObstrucleText,
                controller: confirmPasswordController,
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
                hitText: "Confirm password",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter your Confirm password";
                  } else if (passwordController.text !=
                      confirmPasswordController.text) {
                    return "Please Enter your correct password";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              authNotifier
                  ? const Center(child: CircularProgressIndicator())
                  : BlizerfiCustomButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          ref.read(apiNotifierProvider.notifier).signUp(
                              userNameController.text,
                              emailcontroller.text.trim(),
                              passwordController.text,
                              context);
                        }
                      },
                      text: "Sign up",
                      size: 15,
                      gradientColor: const [
                        Color(0xff15508D),
                        Color(0xff1D6FC3),
                      ],
                      borderRadius: 10,
                    ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Have an account? ',
                    style: const TextStyle(color: Colors.black, fontSize: 16.0),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Login',
                        style: const TextStyle(
                          color: Color(0xff15508D),
                          fontWeight: FontWeight.w500,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignInScreen()),
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

  bool isPasswordValid(String password) {
    String pattern =
        r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$&*~])(?=.*[a-z]).{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }
}
