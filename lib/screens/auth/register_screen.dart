import 'package:flutter/material.dart';
import 'package:social_app/layout.dart';
import 'package:social_app/screens/auth/login_screen.dart';
import 'package:social_app/screens/home_screen.dart';
import 'package:social_app/services/auth.dart';
import 'package:social_app/widgets/login_register_screen_widgets.dart/app_name_widget.dart';
import 'package:social_app/widgets/login_register_screen_widgets.dart/custom_button_widget.dart';
import 'package:social_app/widgets/login_register_screen_widgets.dart/custom_check_having_email_widget.dart';
import 'package:social_app/widgets/login_register_screen_widgets.dart/custom_text_field.dart';
import 'package:social_app/widgets/login_register_screen_widgets.dart/logo_widget.dart';
import 'package:social_app/widgets/login_register_screen_widgets.dart/password_text_field_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController userNameController = TextEditingController();

  final TextEditingController passController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  bool isPass = true;
  final GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
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
                      textEditingController: nameController,
                      icon: Icons.person_outline,
                      label: 'Display Name',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextField(
                      textEditingController: userNameController,
                      icon: Icons.atm_outlined,
                      label: 'Username',
                    ),
                    const SizedBox(
                      height: 15,
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
                              'REGISTER',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                      onTap: () async {
                        isLoading = true;
                        setState(() {});
                        if (formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          await checkRegisteringStatus();
                          if (result == 'success') {
                            isLoading = false;
                            setState(() {});
                            Navigator.pushReplacement(
                                // ignore: use_build_context_synchronously
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LayoutWidget(),
                                ));
                          } else {
                            // ignore: use_build_context_synchronously
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
                          setState(() {});
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomCheckHavingEmailWidget(
                      checkingMessage: "Have an account?  ",
                      actionMessage: 'Login Now.',
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                            (route) => false);
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

  Future<void> checkRegisteringStatus() async {
    result = await Authentication().createUserWithEmailAndPassword(
      email: emailController.text,
      pass: passController.text,
      displayName: nameController.text,
      userName: userNameController.text,
    );
  }
}
