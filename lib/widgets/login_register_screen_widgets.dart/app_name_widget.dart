

import 'package:flutter/material.dart';
import 'package:social_app/colors/app_colors.dart';

class AppNameWidget extends StatelessWidget {
  const AppNameWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          "06",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        Text(
          "16",
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}