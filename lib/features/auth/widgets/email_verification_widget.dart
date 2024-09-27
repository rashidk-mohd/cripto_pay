
import 'package:blizerpay/common/widgets/blizerfi_custom_button.dart';
import 'package:blizerpay/common/widgets/text_widgets.dart';
import 'package:blizerpay/core/utils.dart';
import 'package:blizerpay/features/auth/controller/forgot_password_notifier.dart';
import 'package:blizerpay/features/auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final forgotNotifier = StateNotifierProvider<SendOtpToMailNotifier, bool>(
  (ref) {
    final authRepository = AuthenticationRepository();
    return SendOtpToMailNotifier(authRepository);
  },
);

class EmailVerificationWidget extends StatefulWidget {
 const EmailVerificationWidget({super.key});

  @override
  State<EmailVerificationWidget> createState() => _EmailVerificationWidgetState();
}

class _EmailVerificationWidgetState extends State<EmailVerificationWidget> {
  final emailController = TextEditingController();

 final GlobalKey<FormState> formKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context)
            .viewInsets
            .bottom, // Adjust padding for keyboard
        left: 20,
        right: 20,
        top: 20,
      ),
      child: SingleChildScrollView(
        child: Form(
          key:formKey ,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: DmSansFontText(
                    text: "Forgot your password?",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff2A2A2A),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const DmSansFontText(
                text: "Email",
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xff2A2A2A),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.4),
                      width: 1.0,
                    ),
                  ),
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                 validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your Password";
                      } else {
                        return null;
                      }
                    },
              ),
              const SizedBox(height: 60),
              Center(
                child: Consumer(
                  builder: (context, ref, child) {
                    final forgotNotifierWatch = ref.watch(forgotNotifier);
                    return forgotNotifierWatch
                        ? const CircularProgressIndicator()
                        : BlizerfiCustomButton(
                            onPressed: () {
                              final email = emailController.text.trim();
                              print("email: $email");
          if(formKey.currentState!.validate()){
 if (email.isEmpty) {
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   const SnackBar(
                                //       content: Text('Please enter your email')),
                                // );
                                Utile.showSnackBarI(
                                    context, "Please enter your email", false);
                                return;
                              } else {
                                ref
                                    .read(forgotNotifier.notifier)
                                    .sendOtpTomail(emailController.text, context);
                              }
          }
                             
                            },
                            text: "Send code",
                            gradientColor: const [
                              Color(0xff15508D),
                              Color(0xff1D6FC3),
                            ],
                            borderShapeRadius: 10,
                            borderRadius: 10,
                          );
                  },
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
