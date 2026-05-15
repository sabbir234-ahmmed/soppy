import 'package:e_commerce/common/widgets/shimmer/shimmer_effect.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class UListTileShimmer extends StatelessWidget {
  const UListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
          /// brand logo
            UShimmerEffect(width: 50, height: 50, radius: 50,),
            SizedBox(width:USizes.spaceBtwItems,),
            Column(
              children: [
                //brand name
                UShimmerEffect(width: 100, height: 15),
                SizedBox(height: USizes.spaceBtwItems/2,),
                // brand products
                UShimmerEffect(width: 80, height: 12),
              ],
            )
        ],
        ),
      ],
    );
  }
}
