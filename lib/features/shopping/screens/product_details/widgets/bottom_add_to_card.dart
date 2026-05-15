
import 'package:e_commerce/common/widgets/icons/circular_icon.dart';
import 'package:e_commerce/features/shopping/controllers/card/cart_controller.dart';
import 'package:e_commerce/features/shopping/models/product_model.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UBottomAddToCart extends StatelessWidget {
  const UBottomAddToCart({super.key, required this.product});

  /// variables
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    bool dark = UHelperFunction.isDarkMode(context);
    /// cartController
    final cartController= CartController.instance;

     // for real time rendering curr item count in cart
     cartController.updateAlreadyAddedProductCount(product);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: USizes.defaultSpace, vertical: USizes.defaultSpace /2),
      decoration: BoxDecoration(
        color: dark ? UColors.darkerGrey : UColors.light,
        borderRadius: BorderRadius.only(topLeft:Radius.circular(USizes.cardRadiusLg) , topRight:Radius.circular(USizes.cardRadiusLg))
      ),
      child: Obx(
        ()=> Row(
          children: [

            ///decrement icon or button
            UCircularIcon(
                icon: Iconsax.minus,
                backgroundColor: UColors.darkerGrey,
                width: 40,
                height: 40,
                color: UColors.white,
                onPressed: cartController.productQuantityInCart.value <1 ? null :()=> cartController.productQuantityInCart-=1,

            ),
            SizedBox(width: USizes.spaceBtwItems,),
            ///text
            Text("${cartController.productQuantityInCart.value}", style: Theme.of(context).textTheme.titleSmall,),
            SizedBox(width: USizes.spaceBtwItems,),

            ///increment  icon or button
            UCircularIcon(
              icon: Iconsax.add,
              backgroundColor: UColors.black,
              width: 40,
              height: 40,
              color: UColors.white,
              onPressed: ()=> cartController.productQuantityInCart.value+=1,
            ),
            Spacer(),

            /// add to cart button
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(USizes.md),
                  backgroundColor: UColors.black,
                  side: BorderSide(color: UColors.black),
                ),
                onPressed: cartController.productQuantityInCart.value<1 ? null:  ()=>cartController.addToCart(product),

                child: Row(
                  children: [
                    Icon(Iconsax.shopping_cart),
                    SizedBox(width: USizes.spaceBtwItems /2,),
                    Text("Add To Cart"),

                  ],
                ),
            )
          ],
        ),
      ),
    );
  }
}
