import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:social_app/colors/app_colors.dart';

class CustomCheckHavingEmailWidget extends StatelessWidget {
  const CustomCheckHavingEmailWidget({
    super.key,
    required this.checkingMessage,
    required this.actionMessage,
    this.onTap,
  });
  final String checkingMessage;
  final String actionMessage;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: checkingMessage,
        style: const TextStyle(
          color: Colors.black,
        ),
        children: [
          TextSpan(
            text: actionMessage,
            style: TextStyle(
              fontSize: 16,
              color: kPrimaryColor,
              fontWeight: FontWeight.w500,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
