

import 'package:e_commerce/features/shopping/controllers/card/cart_controller.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/text.dart';
import 'package:e_commerce/utils/helpers/pricing_calculator.dart';
import 'package:flutter/material.dart';

class UBillingAmountSection extends StatelessWidget {
  const UBillingAmountSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cartController= CartController.instance;
    final subTotal= cartController.totalCartPrice.value;
    final double orderTotal=UPricingCalculator.calculateTotalPrice(subTotal, "Bangladesh");

    return Column(
      children: [
        //amount section
        Column(
          children: [
            ///subTotal
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Subtotal", style: Theme.of(context).textTheme.bodyMedium,),
                Text("${UTexts.currency}$subTotal", style: Theme.of(context).textTheme.bodyMedium,),
              ],
            ),
            SizedBox(height: USizes.spaceBtwItems/2,),

            ///shipping Fee
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Shipping Fee", style: Theme.of(context).textTheme.bodyMedium,),
                Text("${UTexts.currency}${UPricingCalculator.getShippingCost("Bangladesh")}", style: Theme.of(context).textTheme.bodyMedium,),
              ],
            ),
            SizedBox(height: USizes.spaceBtwItems/2,),

            ///Tax Fee
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Tax Fee", style: Theme.of(context).textTheme.bodyMedium,),
                Text("${UTexts.currency}${UPricingCalculator.getTaxRateForLocation("Bangladesh")}", style: Theme.of(context).textTheme.bodyMedium,),
              ],
            ),
            SizedBox(height: USizes.spaceBtwItems,),

            /// Order total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Order Total", style: Theme.of(context).textTheme.titleMedium),
                Text("${UTexts.currency}${orderTotal.toStringAsFixed(2)}", style: Theme.of(context).textTheme.titleMedium,),
              ],
            ),


          ],
        ),

      ],
    );
  }
}