import 'package:e_commerce/common/styles/shadow.dart';
import 'package:e_commerce/common/widgets/button/add_to_cart_button.dart';
import 'package:e_commerce/common/widgets/custom_shapes/rounded_container.dart';
import 'package:e_commerce/common/widgets/icons/circular_icon.dart';
import 'package:e_commerce/common/widgets/images/rounded_image.dart';
import 'package:e_commerce/common/widgets/products/favourite/favourite_icon.dart';
import 'package:e_commerce/common/widgets/texts/brand_title_with_verify_icon.dart';
import 'package:e_commerce/common/widgets/texts/product_price_text.dart';
import 'package:e_commerce/common/widgets/texts/product_title_text.dart';
import 'package:e_commerce/features/shopping/controllers/product/product_controller.dart';
import 'package:e_commerce/features/shopping/models/product_model.dart';
import 'package:e_commerce/features/shopping/screens/product_details/product_details.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UProductCardVertical extends StatelessWidget {
  const UProductCardVertical({super.key, required this.product, });

  final ProductModel product ;

  @override
  Widget build(BuildContext context) {

    /// product controller
    final productController= ProductController.instance;
    //for checking dark mode or not
    final dark = UHelperFunction.isDarkMode(context);

    String? salePercentage=productController.calculateSalePercentage(product.price, product.salePrice);

    return GestureDetector(
       onTap: (){
         Get.to(ProductDetailsScreen(product: product,));
       },
        child: Container(

        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: UShadow.verticalProductShadow,
          borderRadius: BorderRadius.circular(USizes.productImageRadius),
          color: dark ? UColors.darkerGrey : UColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// thumbnail, favorite button , discount tag
            URoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(USizes.sm),
              backgroundColor: dark ? UColors.grey : UColors.light,
              child: Stack(
                children: [
                  //thumbnail
                  Center(child: URoundedImage(imageUrl: product.thumbnail,isNetworkImage: true, )),
                  //discount tag
                  if(salePercentage!=null)
                  Positioned(
                    top: 12.0,
                    child: URoundedContainer(
                      radius: USizes.sm,
                      backgroundColor: UColors.yellow.withValues(alpha: 0.8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: USizes.sm,
                        vertical: USizes.xs,
                      ),
                      child: Text(
                        "$salePercentage%",
                        style: Theme.of(
                          context,
                        ).textTheme.labelLarge!.apply(color: UColors.black),
                      ),
                    ),
                  ),

                  //favourite button
                  Positioned(
                    top: 0,
                    right: 0,
                    child:UFavouriteIcon(productId: product.id,),
                  ),
                ],
              ),
            ),

            //space
            SizedBox(height: USizes.spaceBtwItems / 2),

            ///  product details

            //product title, brand, tick mark
            Padding(
              padding: const EdgeInsets.only(left: USizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///product title
                  UProductTitleText(title: product.title, smallSize: true),
                  ///space
                  SizedBox(height: USizes.spaceBtwItems / 2),
                  ///brand name and tick mark
                  UBrandTitleWithVerifyIcon(
                   title: product.brand!.name,
                  ),
                ],
              ),
            ),

             Spacer(),
            //product price , plus icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //product price
                Padding(
                  padding: const EdgeInsets.only(left: USizes.sm),
                  child: UProductPriceText(
                    price: productController.getProductPrice(product),
                  ),
                ),

                ///add icon--------------
                ProductAddToCartButton(product:product),
              ],
            ),

          ],
        ),
      ),
    );
  }
}






