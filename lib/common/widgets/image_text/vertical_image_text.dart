import 'package:e_commerce/common/widgets/custom_shapes/circular_container.dart';
import 'package:e_commerce/common/widgets/images/circular_image.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

class UVerticalImageText extends StatelessWidget {
  const UVerticalImageText({
    super.key,
    required this.title,
    required this.image,
    required this.textColor,
    this.backgroundColor,
    this.onTap,
  });

  //for customize
  final String title, image;
  final Color textColor;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    /// for dark mode
    final bool dark = UHelperFunction.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          ///circlurar image
          UCircularImage(
              height: 56,
              width: 56,
              image: image,
              isNetworkImage: true,
          ),

          //space
          SizedBox(height: USizes.spaceBtwItems / 2),

          ///label text
          SizedBox(
            width: 55,
            child: Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.labelMedium!.apply(color: textColor),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
