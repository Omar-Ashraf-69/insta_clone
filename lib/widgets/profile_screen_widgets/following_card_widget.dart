
import 'package:flutter/material.dart';
import 'package:image_stack/image_stack.dart';
import 'package:social_app/colors/app_colors.dart';

class FollowingCardWidget extends StatelessWidget {
  const FollowingCardWidget({
    super.key,
    required this.label,
  });
  final String label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        child: Column(
          children: [
            ImageStack(
              imageSource: ImageSource.Asset,
              imageList:const [
                'assets/man.png',
                'assets/woman.png',
              ],
              imageRadius: 30,
              totalCount: 0,
              imageBorderWidth: 2,
              imageBorderColor: kWhiteColor,
            ),
            Text("0 $label"),
          ],
        ),
      ),
    );
  }
}
