import 'package:e_commerce/common/widgets/custom_shapes/rounded_container.dart';
import 'package:e_commerce/common/widgets/shimmer/shimmer_effect.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class UHorizontalProductShimmer extends StatelessWidget {
  const UHorizontalProductShimmer({super.key, this.itemCount=4});

  /// variables
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return Container(
     // width: 310,
      height: 120,
      margin: EdgeInsets.only(bottom: USizes.spaceBtwSections),

      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        separatorBuilder: (context,index){
           return SizedBox(width: USizes.spaceBtwItems,);
         },
        itemBuilder: (context,index){
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// image shimmer
             UShimmerEffect(width: 120, height: 120),
              SizedBox(width: USizes.spaceBtwItems,),

              /// text shimmer
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: USizes.spaceBtwItems,),
                      /// title shimmer
                      UShimmerEffect(width: 160, height: 15),
                      //size box
                      SizedBox(height: USizes.spaceBtwItems,),
                      /// brand shimmer
                      UShimmerEffect(width: 110, height: 15),

                      Column(
                        children: [
                        Row(children: [
                          // price shimmer
                          UShimmerEffect(width: 40, height: 20),
                          SizedBox(width: USizes.spaceBtwSections,),
                          //pluse button shimmer
                          UShimmerEffect(width: 40, height: 20),
                        ],)
                      ],)

                  ],)
                ],
              ) ,
          ],);
        },
      ),
    );
  }
}
