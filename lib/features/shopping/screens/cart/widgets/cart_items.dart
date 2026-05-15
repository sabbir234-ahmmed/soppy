import 'package:e_commerce/common/widgets/products/cart/cart_item.dart';
import 'package:e_commerce/common/widgets/products/cart/product_quantity_with_add_remove.dart';
import 'package:e_commerce/common/widgets/texts/product_price_text.dart';
import 'package:e_commerce/features/shopping/controllers/card/cart_controller.dart';
import 'package:e_commerce/features/shopping/models/cart_item_model.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UCartItems extends StatelessWidget {
  const UCartItems({
    super.key,  this.showAddRemoveButtonAndPrice=true,
  });

  final bool showAddRemoveButtonAndPrice;


  @override
  Widget build(BuildContext context) {
    final cartController= CartController.instance;

    return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index){
            return SizedBox(height: USizes.spaceBtwSections,);
          },

          itemCount:cartController.cartItems.length ,
          itemBuilder: (context, index){

             final CartItemModel cartItem= cartController.cartItems[index];
            return Column(
              children: [
                ///item's properties
                UCartItem(cartItem: cartItem),
                ///vertical space
                if(showAddRemoveButtonAndPrice)SizedBox(height: USizes.spaceBtwItems,),
                ///  Counter Buttons
                if(showAddRemoveButtonAndPrice)Row(
                  children: [
                    // extra space
                    SizedBox(width: 70.0,),
                    // quantity with buttons
                    UProductQuantityWithAddRemove(quantity: cartItem.quantity,add: ()=> cartController.addOneToCart(cartItem), remove: ()=>cartController.removeOneFromCart(cartItem),),
                    Spacer(),
                    /// price
                    UProductPriceText(price:(cartItem.price * cartItem.quantity).toStringAsFixed(0)),

                  ],
                ),
              ],
            );
          }
      );

  }
}