
import 'package:e_commerce/features/shopping/controllers/card/cart_controller.dart';
import 'package:e_commerce/features/shopping/screens/cart/cart.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UCartCounterIcon extends StatelessWidget {
  const UCartCounterIcon({
    super.key,
    this.dark=false,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    /// cartController
    final cartController=Get.put(CartController());

    return Stack(
      children: [
        /// bag icon
        IconButton(
          onPressed:(){
            Get.to(CartScreen());
          },
          icon: const Icon(Iconsax.shopping_bag),
          color: dark? UColors.dark: UColors.light,
        ),

        /// circle counter
        Positioned(
          right: 6.0,
          child: Container(
            height: 18,
            width: 18,
            decoration: BoxDecoration(
              color: dark? UColors.dark: UColors.grey,
              shape: BoxShape.circle,
            ),

            child: Center(child: Obx(()=> Text("${cartController.noOfCartItems.value}", style: Theme.of(context).textTheme.labelLarge!.apply(fontSizeFactor: 0.8, color: dark? UColors.light: UColors.dark)))),
          ),
        ),
      ],
    );
  }
}