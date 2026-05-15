import 'package:e_commerce/common/widgets/custom_shapes/rounded_container.dart';
import 'package:e_commerce/features/shopping/controllers/checkout/checkout_controller.dart';
import 'package:e_commerce/features/shopping/models/payment_method_model.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

/// implement list tile under selected payment method
class UPaymentTile extends StatelessWidget{
  const UPaymentTile({super.key, required this.paymentMethod});

  final PaymentMethodModel paymentMethod;

  @override
  Widget build(BuildContext  context){
    /// checkout controller
    final checkoutController= CheckOutController.instance;
    return ListTile(
      onTap: (){
        checkoutController.selectedPaymentMethod.value=paymentMethod;
        // close bottom sheet
        Get.back();
      },
      contentPadding: EdgeInsets.zero,
      /// payment getway Icon
      leading: URoundedContainer(
        height: 50,
        width: 60,
        backgroundColor: UHelperFunction.isDarkMode(context)? UColors.darkGrey : UColors.light,
        padding: EdgeInsets.all(USizes.sm),
        child: Image(image: AssetImage(paymentMethod.image), fit: BoxFit.contain,) ,
      ),
      title: Text(paymentMethod.name),
      trailing: Icon(Iconsax.arrow_right_34),
    );
  }
}