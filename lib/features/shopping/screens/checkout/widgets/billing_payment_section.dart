import 'package:e_commerce/common/widgets/custom_shapes/rounded_container.dart';
import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/features/shopping/controllers/card/cart_controller.dart';
import 'package:e_commerce/features/shopping/controllers/checkout/checkout_controller.dart';
import 'package:e_commerce/features/shopping/models/payment_method_model.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UBillingPaymentSection extends StatelessWidget {
  const UBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final checkoutController= CheckOutController.instance;
    final bool dark =UHelperFunction.isDarkMode(context);
    return Column(

      children: [
         // payment method text
        USectionHeading(
          title: "PayMent Method",
          buttonTittle: "Change",
          onPressed: (){
            checkoutController.selectPaymentMethod(context);
          },
        ),
        //space
        SizedBox(height: USizes.spaceBtwItems/2,),

        /// SELECTED Method Image and title
        Obx(
          (){
            PaymentMethodModel selectedMethod=checkoutController.selectedPaymentMethod.value;
            final String image= (selectedMethod.image!=null && selectedMethod.image.isNotEmpty) ? selectedMethod.image : UImages.masterCard;
            final String name= (selectedMethod.name !=null && selectedMethod.name.isNotEmpty) ? selectedMethod.name : "Master Care";
            return Row(
              children: [
                // payment image or logo
                URoundedContainer(
                  width: 60,
                  height: 35,
                  padding: EdgeInsets.all(USizes.sm),
                  backgroundColor:  dark ? UColors.light : UColors.white,

                  child: Image(image: AssetImage(image), fit: BoxFit.contain,),


                ),

                //space
                SizedBox(width: USizes.spaceBtwItems / 2,),
                // payment method  title
                Text(name, style: Theme.of(context).textTheme.bodyLarge,),

              ],
            );
          }
        ),

      ],
    );
  }
}
