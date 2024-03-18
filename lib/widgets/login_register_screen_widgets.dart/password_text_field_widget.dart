import 'package:flutter/material.dart';
import 'package:social_app/colors/app_colors.dart';

// ignore: must_be_immutable
class PasswordTextField extends StatelessWidget {
  PasswordTextField({
    super.key,
    required this.controller,
    this.onSuffixTap,
    this.isPass = true,
  });
  final TextEditingController controller;
  final void Function()? onSuffixTap;
  bool isPass;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: (value) {},
      obscureText: isPass,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return "Password can't be empty.";
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.password_outlined,
        ),
        suffixIcon: InkWell(
          onTap: onSuffixTap,
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: isPass
                ? const Icon(Icons.remove_red_eye_outlined)
                : const Icon(Icons.remove_red_eye_sharp),
          ),
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
