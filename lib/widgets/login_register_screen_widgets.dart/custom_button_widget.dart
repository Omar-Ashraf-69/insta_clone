import 'package:flutter/material.dart';
import 'package:social_app/colors/app_colors.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    super.key,
    required this.label,
    this.onTap,
    this.buttonColor,
  });
  final Widget label;
  final void Function()? onTap;
  final Color? buttonColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: buttonColor ?? kPrimaryColor,
        ),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 15,
        ),
        child: Center(
          child: label,
        ),
      ),
    );
  }
}
