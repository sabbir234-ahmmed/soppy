import 'package:e_commerce/common/widgets/shimmer/shimmer_effect.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class UBrandsShimmer extends StatelessWidget {
  const UBrandsShimmer({super.key,  this.itemCount=4});

  ///variable
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: itemCount,

      itemBuilder: (context, index) {
        return  UShimmerEffect(width: USizes.brandCardWidth, height: USizes.brandCardHeight);
      },
      separatorBuilder: (context, index) {
        return SizedBox(width: USizes.spaceBtwItems);
      },
    );
  }
}
