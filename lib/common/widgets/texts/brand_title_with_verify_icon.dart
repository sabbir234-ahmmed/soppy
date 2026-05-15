import 'package:e_commerce/common/widgets/texts/brand_title_text.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/enums.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class UBrandTitleWithVerifyIcon extends StatelessWidget {
  const UBrandTitleWithVerifyIcon({
    super.key,
    this.textColor,
    this.iconColor=UColors.primary,
    required this.title,
     this.maxLines=1,
    this.textAlign=TextAlign.center,
    this.brandTextSize=TextSizes.small,
  });

  /// for customizing
  final Color? textColor, iconColor;
  final String title;
  final int maxLines;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //brand name
        Flexible(
          child: UBrandTitleText(
            title: title,
            maxLines: maxLines,
            textAlign: textAlign,
            brandTextSize: brandTextSize,
            color: textColor,
          ),
        ),
        //space
        SizedBox(width: USizes.xs),
        Icon(Iconsax.verify5, color: UColors.primary, size: USizes.iconXs),
      ],
    );
  }
}
