
import 'package:e_commerce/features/shopping/controllers/card/cart_controller.dart';
import 'package:e_commerce/features/shopping/models/cart_item_model.dart';
import 'package:e_commerce/features/shopping/models/product_model.dart';
import 'package:e_commerce/features/shopping/screens/product_details/product_details.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/enums.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProductAddToCartButton extends StatelessWidget {
  const ProductAddToCartButton({super.key, required this.product});

  /// variables
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    /// cart controller
    final cartController=Get.put(CartController());
    return InkWell(
      onTap:(){
        if(product.productType == ProductType.single.toString()){
          // convert cartModel to cartItem
          CartItemModel cartItem= cartController.convertCartItem(product, 1);
          // add cartItem to the cart
          cartController.addOneToCart(cartItem);
        }else{
          Get.to(ProductDetailsScreen(product: product));
        }
      },
      child: Obx(
        ( ){
          // get current product quantity in cart
          int productQuantityInCart= cartController.getProductQuantityInCart(product.id);
         return  Container(
            width: USizes.iconLg * 1.2,
            height: USizes.iconLg * 1.2,

            decoration: BoxDecoration(
              color: productQuantityInCart>0 ? UColors.dark:  UColors.primary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(USizes.cardRadiusMd),
                bottomRight: Radius.circular(
                  USizes.productImageRadius,
                ),
              ),
            ),
            child: productQuantityInCart>0 ?
            Center(
              child: Text("$productQuantityInCart",
                style: Theme.of(context).textTheme.bodyLarge!.apply(color: UColors.white),
              ),
            ) :Icon(Iconsax.add, color: UColors.white),
          );
        },
      ),
    );
  }
}
