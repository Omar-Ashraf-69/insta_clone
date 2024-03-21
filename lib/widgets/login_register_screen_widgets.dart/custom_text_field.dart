import 'package:flutter/material.dart';
import 'package:social_app/colors/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.suffixIcon,
    required this.label,
    this.prefixIcon,
    required this.textEditingController, this.onChanged,
  });
  final TextEditingController textEditingController;
  final String label;
  final Icon? prefixIcon;
  final IconButton? suffixIcon;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      keyboardType: TextInputType.emailAddress,
      onChanged: onChanged,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return "$label can't be empty.";
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        label: Text(
          label,
          style: const TextStyle(
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
