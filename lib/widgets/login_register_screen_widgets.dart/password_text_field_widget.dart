
import 'package:flutter/material.dart';
import 'package:social_app/colors/app_colors.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {},
      obscureText: true,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.password_outlined,
        ),
        suffixIcon: const Padding(
          padding: EdgeInsets.only(right: 16.0),
          child: Icon(Icons.remove_red_eye_outlined),
        ),
        label: const Text(
          "Password",
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        fillColor: kWhiteColor,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
          borderRadius: BorderRadius.circular(16),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
