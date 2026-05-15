import 'package:e_commerce/common/widgets/images/rounded_image.dart';
import 'package:e_commerce/common/widgets/texts/brand_title_with_verify_icon.dart';
import 'package:e_commerce/common/widgets/texts/product_title_text.dart';
import 'package:e_commerce/features/shopping/models/cart_item_model.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

class UCartItem extends StatelessWidget {
  const UCartItem({super.key, required this.cartItem});

  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    final bool dark = UHelperFunction.isDarkMode(context);
    return Row(
      children: [
        /// item image
        URoundedImage(
          height: 60,
          width: 60,
          imageUrl: cartItem.image!,
          isNetworkImage: true,
          padding: EdgeInsets.all(USizes.sm),
          backgroundColor: dark ? UColors.darkerGrey : UColors.light,
        ),

        ///space
        SizedBox(width: USizes.spaceBtwItems),

        /// brand , name and variations
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //brand with verify icon
              UBrandTitleWithVerifyIcon(
                title: cartItem.brandName ?? "Expensive",
              ),
              //Name or title
              UProductTitleText(title: cartItem.title, maxLines: 1),
              //variations or attributes
              RichText(
                text: TextSpan(
                    children:  (cartItem.selectedVariation ??{}).entries.map((e)=> TextSpan(
                    children: [
                      TextSpan(text: "${e.key} ", style: Theme.of(context).textTheme.bodySmall),
                      TextSpan(text: "${e.value}   ", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                    ]
                  )
                  ).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
