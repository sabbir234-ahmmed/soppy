import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/common/widgets/brands/brand_card.dart';
import 'package:e_commerce/common/widgets/custom_shapes/rounded_container.dart';
import 'package:e_commerce/common/widgets/shimmer/shimmer_effect.dart';
import 'package:e_commerce/features/shopping/models/brands_model.dart';
import 'package:e_commerce/features/shopping/screens/brands/brand_products.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UBrandShowcase extends StatelessWidget {
  final List<String> images;
  
  const UBrandShowcase({
    super.key, required this.images, required this.brand
  });

  /// variables
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    // set theme according to device mode
    final bool dark = UHelperFunction.isDarkMode(context);

    return InkWell(
      onTap: ()=> Get.to(()=> BrandProductsScreen(title: brand.name, brand: brand)),
       
      child: URoundedContainer(
        showBorder: true,
        borderColor: UColors.darkGrey,
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.all(USizes.md),
        margin: EdgeInsets.only(bottom: USizes.spaceBtwItems),
        //for multiple showcase
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //brand with product count
            UBrandCard(showBorder: false,brand: brand,),
            //products in a row
            Row(
              children: images.map( (image){
                return buildBrandImage(dark,image);
              }
              ).toList(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildBrandImage(bool dark, String currImage) {

    return Expanded(
      child: URoundedContainer(
        height: 100,
        margin: const EdgeInsets.only(right: USizes.sm),
        padding: const EdgeInsets.all(USizes.md),
        backgroundColor: dark ? UColors.darkGrey : UColors.light,

        child:  CachedNetworkImage(
          imageUrl: currImage, fit: BoxFit.contain,
          progressIndicatorBuilder: (context, url, progress){
           return UShimmerEffect(width: 100, height: 100,);
          },
          errorWidget: (context, url, error){
            return Icon(Icons.error);
          },
        ),
      ),
    );
  }
}
