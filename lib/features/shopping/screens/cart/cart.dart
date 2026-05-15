import 'package:e_commerce/common/styles/padding.dart';
import 'package:e_commerce/common/widgets/appbar/appbar.dart';
import 'package:e_commerce/common/widgets/button/elevated_button.dart';
import 'package:e_commerce/common/widgets/icons/circular_icon.dart';
import 'package:e_commerce/common/widgets/loaders/animation_loader.dart';
import 'package:e_commerce/features/shopping/controllers/card/cart_controller.dart';

import 'package:e_commerce/features/shopping/screens/checkout/checkout.dart';
import 'package:e_commerce/utils/constants/images.dart';

import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';


import 'widgets/cart_items.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController= CartController.instance;

    return Scaffold(
      ///-------[ appbar]---------
      appBar: UAppBar(
       showBackArrow: true,
        title: Text("Cart", style: Theme.of(context).textTheme.headlineMedium,),
        actions: [
          UCircularIcon(
            icon: Iconsax.box_remove,
            onPressed:()=> cartController.clearCart() ,
          ),
        ],
      ),

      ///-------[body]------------
      body: Obx(
        (){

          /// for empty cart
          final Widget emptyWidget= UAnimationLoader(
            text: "Cart is Empty!",
            animation: UImages.cartEmptyAnimation,
            showActionButton: true,
            actionText: "Let's fill it!",
            onActionPressed: ()=>Get.back(),
          );

          if(cartController.cartItems.isEmpty){
            return emptyWidget;
          }
          return SingleChildScrollView(

            child: Padding(
              padding: UPadding.screenPadding,
              child: UCartItems(),
            ),
          );
        }
      ),

      ///-------[Bottom Navigation Bar]---
      bottomNavigationBar: Obx(( ) {
           if (cartController.cartItems.isEmpty){
             return SizedBox();
           }
            final String totalPrice= (cartController.totalCartPrice.value).toStringAsFixed(0);
            return Padding(
            padding: const EdgeInsets.all(USizes.defaultSpace),
            child: UElevatedButton(
              onPressed: (){
                Get.to(CheckOutScreen());
              },
              child: Text("CheckOut \$$totalPrice"),
            ),
          );
        }
      ),


    );
  }
}





