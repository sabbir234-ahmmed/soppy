import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class URoundedImage extends StatelessWidget {
  const URoundedImage({
    super.key,
    this.width,
    this.height,
    this.applyImageRadius = true,
    this.border,
    this.backgroundColor,
    required this.imageUrl,
    this.isNetworkImage = false,
    this.onTap,
    this.borderRadius = USizes.md,
    this.padding,
    this.fit = BoxFit.cover,
  });

  ///variables
  final String imageUrl;
  final double? width, height;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onTap;
  final double borderRadius;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        /// image decoration part
        height: height,
        width: width,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),

        ///image
        child: ClipRRect(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: Image(
            image: isNetworkImage
                ? NetworkImage(imageUrl)
                : AssetImage(imageUrl),
            fit: fit,
          ),
        ),
      ),
    );
  }
}