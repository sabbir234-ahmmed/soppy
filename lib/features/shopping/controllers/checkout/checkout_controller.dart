
import 'package:e_commerce/common/widgets/custom_shapes/rounded_container.dart';
import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/features/shopping/models/payment_method_model.dart';
import 'package:e_commerce/features/shopping/screens/checkout/widgets/payment_tile.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/cloud_helper_functions.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CheckOutController extends GetxController{
  static CheckOutController get instance => Get.find();
  /// variables
  // for tracking which payment method is currently selected
  Rx<PaymentMethodModel> selectedPaymentMethod= PaymentMethodModel.empty().obs;

  /// method for Changing payMent Method
  Future <void> selectPaymentMethod (BuildContext context)async{
    return showModalBottomSheet(context: context,
        builder: (context)=>SingleChildScrollView(
         padding: EdgeInsets.all(USizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              USectionHeading(title: "Select Payment Method",showButton: false,),
              SizedBox(height: USizes.spaceBtwSections,),
              /// payment method 1
              UPaymentTile(paymentMethod: PaymentMethodModel(name: "Cash on delivery", image: UImages.codIcon)),
              SizedBox(height: USizes.spaceBtwItems/2,),
              /// payment method 2
              UPaymentTile(paymentMethod: PaymentMethodModel(name: "Paypal", image: UImages.paypal)),
              SizedBox(height: USizes.spaceBtwItems/2,),
              /// payment method 3
              UPaymentTile(paymentMethod: PaymentMethodModel(name: "Credit Card", image: UImages.creditCard)),
              SizedBox(height: USizes.spaceBtwItems/2,),
              /// payment method 4
              UPaymentTile(paymentMethod: PaymentMethodModel(name: "Master Card", image: UImages.masterCard)),
              SizedBox(height: USizes.spaceBtwSections,),

            ],
          ),
        ));
  }



}


