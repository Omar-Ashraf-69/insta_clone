import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_app/colors/app_colors.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        'assets/n_logo.svg',
        // ignore: deprecated_member_use
        color: kPrimaryColor,
        width: 150,
        height: 150,
      ),
    );
  }
}
