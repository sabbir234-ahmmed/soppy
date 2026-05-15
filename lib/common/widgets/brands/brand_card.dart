
import 'package:e_commerce/common/widgets/custom_shapes/rounded_container.dart';
import 'package:e_commerce/common/widgets/images/rounded_image.dart';
import 'package:e_commerce/common/widgets/texts/brand_title_with_verify_icon.dart';
import 'package:e_commerce/features/shopping/models/brands_model.dart';
import 'package:e_commerce/utils/constants/enums.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class UBrandCard extends StatelessWidget {
  const UBrandCard({
    super.key,
    this.showBorder=true,
    this.onTap,
    required this.brand
  });

  /// variables
  final bool showBorder ;
  final VoidCallback? onTap;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       onTap: onTap,
      child: URoundedContainer(
        //width:  USizes.brandCardWidth,
        height: USizes.brandCardHeight,
        showBorder: showBorder,
        padding: EdgeInsets.all(USizes.sm),
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            ///brand image
            Flexible(
              child: URoundedImage(
                backgroundColor: Colors.transparent,
                imageUrl: brand.image,
                isNetworkImage: true,
                height: 50,
                width: 50,
              ),
            ),
            //space
            SizedBox(width: USizes.spaceBtwItems/2,),

            /// brand name and verify icon,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  UBrandTitleWithVerifyIcon(
                    title: brand.name,
                    brandTextSize: TextSizes.large,
                  ),
                  /// amount of product
                  Text("${brand.productsCount} products",style: Theme.of(context).textTheme.labelMedium, overflow: TextOverflow.ellipsis,),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}