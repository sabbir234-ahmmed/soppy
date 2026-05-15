
import 'package:e_commerce/common/styles/shadow.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/text.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class USearchBar extends StatelessWidget {
  const USearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool dark =UHelperFunction.isDarkMode(context);
    return Positioned(
      bottom: 0,
      right: USizes.spaceBtwSections,
      left: USizes.spaceBtwSections,

      child: Container(
        padding: EdgeInsets.symmetric(horizontal: USizes.md ) ,
        height: USizes.searchBarHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(USizes.borderRadiusLg),
          color: dark? UColors.dark: UColors.light,
          boxShadow: UShadow.searchBarShadow,

        ),

        child: Row(
          children: [
            ///  search icon
            Icon(Iconsax.search_normal, color: UColors.darkGrey,),
            //space
            SizedBox(width: USizes.spaceBtwItems,),
            /// search bar title
            Text(UTexts.searchBarTitle, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: dark? UColors.light: UColors.darkerGrey.withValues(alpha: 0.6))),
          ],
        ),
      ),
    );
  }
}