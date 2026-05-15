import 'package:e_commerce/common/widgets/shimmer/shimmer_effect.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class UBoxesShimmer extends StatelessWidget {
  const UBoxesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(children: [
          // three products
          Expanded(child: UShimmerEffect(width: 150, height: 110),),
          SizedBox(width: USizes.spaceBtwItems,),
          Expanded(child: UShimmerEffect(width: 150, height: 110),),
          SizedBox(width: USizes.spaceBtwItems,),
          Expanded(child: UShimmerEffect(width: 150, height: 110),),

        ],)
      ],
    );
  }
}
