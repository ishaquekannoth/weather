import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/core/themes/colors.dart';
import 'package:weather/core/widgets/components/skeleton.dart';
import 'package:weather/core/widgets/shared/ui_helpers.dart';

class ImageWidget<T extends Object> extends StatelessWidget {
  final T data;
  final String imageUrl;
  final double height;
  final double? width;
  final WidgetDataExporter<T>? onTap;
  final BoxFit boxFit;
  final BorderRadiusGeometry borderRadius;
  final Gradient? gradient;
  final bool disableBlackGradient;

  const ImageWidget({
    super.key,
    required this.imageUrl,
    required this.height,
    this.width,
    this.borderRadius = BorderRadius.zero,
    this.boxFit = BoxFit.fill,
    this.onTap,
    required this.data,
    this.gradient,
    this.disableBlackGradient = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap != null ? () => onTap!(data) : null,
      child: Stack(
        children: [
          // Background image
          ClipRRect(
            borderRadius: borderRadius,
            child: CachedNetworkImage(
              height: height,
              width: width,
              imageUrl: imageUrl,
              fit: boxFit,
              progressIndicatorBuilder: (context, url, progress) => Skeleton(),
              errorWidget: (context, url, error) => SizedBox(
                height: height,
                width: width,
                child: const Icon(
                  CupertinoIcons.exclamationmark_octagon_fill,
                  color: AppColors.crimsonRed,
                ),
              ),
            ),
          ),

          if (!disableBlackGradient)
            Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                gradient:
                    gradient ??
                    LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                      colors: [Colors.black.withAlpha(205), Colors.transparent],
                    ),
              ),
            ),
        ],
      ),
    );
  }
}
