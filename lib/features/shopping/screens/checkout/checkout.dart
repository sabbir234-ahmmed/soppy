
import 'package:e_commerce/common/screens/success_screen.dart';
import 'package:e_commerce/common/styles/padding.dart';
import 'package:e_commerce/common/widgets/appbar/appbar.dart';
import 'package:e_commerce/common/widgets/button/elevated_button.dart';
import 'package:e_commerce/common/widgets/custom_shapes/rounded_container.dart';
import 'package:e_commerce/common/widgets/textfields/promo_code.dart';
import 'package:e_commerce/data/repository/order/order_repository.dart';
import 'package:e_commerce/features/shopping/controllers/card/cart_controller.dart';
import 'package:e_commerce/features/shopping/controllers/order_controller/order_controller.dart';
import 'package:e_commerce/features/shopping/screens/cart/widgets/cart_items.dart';
import 'package:e_commerce/features/shopping/screens/checkout/widgets/billing_address_section.dart';
import 'package:e_commerce/features/shopping/screens/checkout/widgets/billing_amount_section.dart';
import 'package:e_commerce/features/shopping/screens/checkout/widgets/billing_payment_section.dart';
import 'package:e_commerce/navigation_menu.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:e_commerce/utils/constants/keys.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/text.dart';
import 'package:e_commerce/utils/helpers/pricing_calculator.dart';
import 'package:e_commerce/utils/popups/snackbar_helpers.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {

    //final cartController= Get.put(CartController());
    final cartController= CartController.instance;
    final double subTotal= cartController.totalCartPrice.value;
    final double totalPrice=UPricingCalculator.calculateTotalPrice(subTotal, "Bangladesh");

    final OrderController orderController= Get.put(OrderController());


    return Scaffold(

      ///-----------[ App Bar ]---------
      appBar: UAppBar(
       showBackArrow: true,
        title: Text("Order Review", style: Theme.of(context).textTheme.headlineSmall,),
      ),

      ///-----------[ Body ]---------
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              // items
              UCartItems(showAddRemoveButtonAndPrice: false,),

              //space
              SizedBox(height: USizes.spaceBtwSections),

              // promo code - text field, apply
              UPromoCodeField(),
              ///space
              SizedBox(height: USizes.spaceBtwSections,),

              /// Billing section
              URoundedContainer(
                  showBorder: true,
                  padding: EdgeInsets.all(USizes.sm),
                  backgroundColor: Colors.transparent,

                  child: Column(
                    children: [

                      //billing amount section
                      UBillingAmountSection(),

                      ///space
                      SizedBox(height: USizes.spaceBtwItems,),

                      //billing payment section
                      UBillingPaymentSection(),

                      ///space
                      SizedBox(height: USizes.spaceBtwItems,),

                      //billing Address section
                      UBillingAddressSection(),

                    ],
                  )
              ),



            ],
          ),
        ),
      ),


      ///-------[Bottom Navigation Bar]---
      ///checkout button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(USizes.defaultSpace),
        child: UElevatedButton(
          onPressed: (){
            if(subTotal>0){
              orderController.processOrder(totalPrice);
            }else{
              USnackBarHelpers.errorSnackBar(title: "Cart is Empty", message: "Add Item to The Cart.");
            }

          },
          child: Text("CheckOut ${UTexts.currency}${UPricingCalculator.calculateTotalPrice(subTotal, "Bangladesh").toStringAsFixed(2)}"),
        ),
      ),


    );
  }
}



