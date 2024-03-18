import 'package:flutter/material.dart';
import 'package:social_app/screens/home_screen.dart';
import 'package:social_app/screens/register_screen.dart';
import 'package:social_app/services/auth.dart';
import 'package:social_app/widgets/login_register_screen_widgets.dart/app_name_widget.dart';
import 'package:social_app/widgets/login_register_screen_widgets.dart/custom_button_widget.dart';
import 'package:social_app/widgets/login_register_screen_widgets.dart/custom_check_having_email_widget.dart';
import 'package:social_app/widgets/login_register_screen_widgets.dart/custom_text_field.dart';
import 'package:social_app/widgets/login_register_screen_widgets.dart/logo_widget.dart';
import 'package:social_app/widgets/login_register_screen_widgets.dart/password_text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController passController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  bool isPass = true;
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool isLoading = false;
  String result = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AbsorbPointer(
        absorbing: isLoading,
        child: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const LogoWidget(),
                    const SizedBox(
                      height: 25,
                    ),
                    const AppNameWidget(),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      textEditingController: emailController,
                      icon: Icons.email_outlined,
                      label: 'Email',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    PasswordTextField(
                      controller: passController,
                      isPass: isPass,
                      onSuffixTap: () {
                        isPass = !isPass;
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    CustomButtonWidget(
                      label: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'LOGIN',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                      onTap: () async {
                        isLoading = true;
                        setState(() {});
                        if (formKey.currentState!.validate())   {
                          await checkSignStatus();
                          if (result == 'success') {
                            isLoading = false;
                            setState(() {});
                            Navigator.pushReplacement(
                                // ignore: use_build_context_synchronously
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  result,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            );
                            isLoading = false;
                            setState(() {});
                          }
                        } else {
                          autovalidateMode = AutovalidateMode.always;
                          isLoading = false;
                          setState(() {});
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomCheckHavingEmailWidget(
                      checkingMessage: "Don't have an account?  ",
                      actionMessage: 'Register Now.',
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> checkSignStatus() async {
    result = await Authentication().signInWithEmailAndPassword(
      email: emailController.text,
      pass: passController.text,
    );
  }
}
