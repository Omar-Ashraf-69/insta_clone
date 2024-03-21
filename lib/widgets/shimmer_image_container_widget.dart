import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:social_app/colors/app_colors.dart';

class ShimmerImageContainer extends StatelessWidget {
  const ShimmerImageContainer({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: FancyShimmerImage(
          imageUrl: imageUrl,
          boxFit: BoxFit.cover,
          errorWidget: const Icon(Icons.error),
          shimmerBaseColor: Colors.grey,
          shimmerHighlightColor: Colors.white,
        ),
      ),
    );
  }
}
