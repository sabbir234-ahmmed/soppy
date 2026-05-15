
import 'package:e_commerce/common/widgets/appbar/appbar.dart';
import 'package:e_commerce/common/widgets/products/cart/cart_counter_icon.dart';
import 'package:e_commerce/common/widgets/shimmer/shimmer_effect.dart';
import 'package:e_commerce/features/personalization/controllers/user_controller.dart';
import 'package:e_commerce/features/shopping/controllers/card/cart_controller.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/text.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UHomeAppBar extends StatelessWidget {
  const UHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final controller= Get.put(UserController());
    return UAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        /// title and sub title at appbar
         children: [
          //title wishing
          Text(UHelperFunction.getGreetingMessage(), style: Theme.of(context).textTheme.labelMedium!.apply(color: UColors.grey)),
          //subtitle name
          Obx( (){
           if(controller.profileLoading.value){
             return UShimmerEffect(width: 100, height: 15);
           }
           return Text(controller.user.value.fullName, style: Theme.of(context).textTheme.headlineSmall!.apply(color: UColors.white));
          }),
        ],
      ),

      actions: [
        //at appbar trail position bag icon
        UCartCounterIcon(),
      ],
    );
  }
}