import 'package:e_commerce/common/widgets/icons/circular_icon.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class UProductQuantityWithAddRemove extends StatelessWidget {
  const UProductQuantityWithAddRemove({
    super.key, required this.quantity, this.add, this.remove,

  });

  /// variables
  final int quantity;
  final VoidCallback? add, remove;

  @override
  Widget build(BuildContext context) {
    final bool dark =UHelperFunction.isDarkMode(context);
    return Row(
      children: [
        // minus icon or decrement Button
        UCircularIcon(
          icon: Iconsax.minus,
          height: 32,
          width: 32,
          size: USizes.iconSm,
          color: dark ? UColors.white : UColors.black ,
          backgroundColor: dark ? UColors.darkerGrey : UColors.light ,
          onPressed: remove,
        ),

        /// Space
        SizedBox(width: USizes.spaceBtwItems,),

        //quantity
        Text( "$quantity", style: Theme.of(context).textTheme.titleSmall,),


        /// Space
        SizedBox(width: USizes.spaceBtwItems,),

        //plus icon or increment button
        UCircularIcon(
          icon: Iconsax.add,
          height: 32,
          width: 32,
          size: USizes.iconSm,
          color:  UColors.white ,
          backgroundColor: UColors.primary ,
          onPressed: add,
        ),
      ],
    );
  }
}