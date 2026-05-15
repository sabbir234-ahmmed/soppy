import 'package:e_commerce/common/widgets/button/add_to_cart_button.dart';
import 'package:e_commerce/common/widgets/custom_shapes/rounded_container.dart';
import 'package:e_commerce/common/widgets/icons/circular_icon.dart';
import 'package:e_commerce/common/widgets/images/rounded_image.dart';
import 'package:e_commerce/common/widgets/products/favourite/favourite_icon.dart';
import 'package:e_commerce/common/widgets/texts/brand_title_with_verify_icon.dart';
import 'package:e_commerce/common/widgets/texts/product_price_text.dart';
import 'package:e_commerce/common/widgets/texts/product_title_text.dart';
import 'package:e_commerce/features/shopping/controllers/card/cart_controller.dart';
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

class UProductCardHorizontal extends StatelessWidget {
  const UProductCardHorizontal({
    super.key, required this.categoryProduct,

  });

  /// variables
  final ProductModel categoryProduct;

  @override
  Widget build(BuildContext context) {
    /// cart controller
    final cartController= CartController.instance;
    /// product controller
    final productController= ProductController.instance;
    final bool dark =UHelperFunction.isDarkMode(context);

    /// get sale
    String? salePercentage=productController.calculateSalePercentage(categoryProduct.price, categoryProduct.salePrice);

    return GestureDetector(
      onTap: (){
        Get.to(ProductDetailsScreen(product: categoryProduct,));
      },
      child: Container(
        width: 310,
        padding:EdgeInsets.all(1) ,
        decoration:
        BoxDecoration(
          borderRadius: BorderRadius.circular(USizes.productImageRadius),
          color: dark ? UColors.darkerGrey :UColors.grey,
        ),
        child: Row(

          children: [
            /// left portion
            URoundedContainer(
              height: 120,
              padding: EdgeInsets.all(USizes.sm),
              backgroundColor: dark ? UColors.dark: UColors.light,
              child: Stack(
                children: [
                  /// rounded product's image
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: URoundedImage(
                      imageUrl: categoryProduct.thumbnail,
                      isNetworkImage: true,
                    ),
                  ),

                  ///discount tag
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

                  ///favourite button
                  Positioned(
                    top: 0,
                    right: 0,
                    child: UFavouriteIcon(productId: categoryProduct.id,),
                  ),
                ],
              ),
            ),
            /// right portion
            SizedBox(
              width: 170.0,
              child: Padding(
                padding: const EdgeInsets.only(left: USizes.sm, top: USizes.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// upper column
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// product's title
                        UProductTitleText(title: categoryProduct.title, smallSize: true,),
                        //space
                        SizedBox(height: USizes.spaceBtwItems/2,),
                        /// product's brand
                        UBrandTitleWithVerifyIcon(title: categoryProduct.brand!.name),
                      ],
                    ),
                    //spacer
                    Spacer(),
                    ///lower column with row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //product price
                        Padding(
                          padding: const EdgeInsets.only(left: USizes.sm),
                          child: Flexible(
                            child: UProductPriceText(
                              price: productController.getProductPrice(categoryProduct),
                            ),
                          ),
                        ),

                        //add icon ,
                        ProductAddToCartButton(product: categoryProduct),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),

      ),
    );
  }
}