import 'package:flutter/material.dart';
import 'package:social_app/screens/register_screen.dart';
import 'package:social_app/widgets/login_register_screen_widgets.dart/app_name_widget.dart';
import 'package:social_app/widgets/login_register_screen_widgets.dart/custom_button_widget.dart';
import 'package:social_app/widgets/login_register_screen_widgets.dart/custom_check_having_email_widget.dart';
import 'package:social_app/widgets/login_register_screen_widgets.dart/custom_text_field.dart';
import 'package:social_app/widgets/login_register_screen_widgets.dart/logo_widget.dart';
import 'package:social_app/widgets/login_register_screen_widgets.dart/password_text_field_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                const CustomTextField(
                  icon: Icons.email_outlined,
                  label: 'Email',
                ),
                const SizedBox(
                  height: 15,
                ),
                const PasswordTextField(),
                const SizedBox(
                  height: 25,
                ),
                const CustomButtonWidget(
                  label: 'LOGIN',
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomCheckHavingEmailWidget(
                  checkingMessage: "Don't have an account?  ",
                  actionMessage: 'Register Now.',
                  onTap: () {
                    Navigator.push(
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
    );
  }
}
