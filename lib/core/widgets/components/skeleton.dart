import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather/core/themes/colors.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({super.key, this.height, this.width});

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      direction: ShimmerDirection.rtl,
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        tileMode: TileMode.mirror,
        colors: [
          AppColors.primaryColor,
          AppColors.pearlWhite,
          AppColors.primaryColor,
        ],
      ),
      child: Container(
        color: AppColors.blackOnyx,
        height: height,
        width: width,
      ),
    );
  }
}

class CircleSkeleton extends StatelessWidget {
  const CircleSkeleton({super.key, this.size = 24});

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      direction: ShimmerDirection.rtl,
      gradient: RadialGradient(
        tileMode: TileMode.mirror,
        colors: [
          AppColors.primaryColor,
          AppColors.pearlWhite,
          AppColors.primaryColor,
        ],
      ),
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withAlpha(20),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
