
import 'package:e_commerce/common/widgets/brands/brand_showcase.dart';
import 'package:e_commerce/common/widgets/shimmer/boxes_shimmer.dart';
import 'package:e_commerce/common/widgets/shimmer/list_tile_shimmer.dart';
import 'package:e_commerce/features/shopping/controllers/brand/brand_controller.dart';
import 'package:e_commerce/features/shopping/models/category_model.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.category});

  ///variables
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final brandController= Get.put(BrandController());


    return FutureBuilder(
      future: brandController.getBrandForCategory(category.id),
      builder: (context, snapshot) {
        const loader=Column(
          children: [
            UListTileShimmer(),
            SizedBox(height: USizes.spaceBtwItems,),
            UBoxesShimmer(),
            SizedBox(height: USizes.spaceBtwItems,),
          ],
        );

        final widget=UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
        if(widget!=null){
          return widget;
        }

        final brands= snapshot.data!;
        return ListView.builder(
          shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: brands.length,
            itemBuilder: (context, index){
              final brand=brands[index];
              return FutureBuilder(
                  future:brandController.getBrandProducts(brand.id, limit: 3) ,
                  builder: (context, snapshot){
                    // handle loader , no record or error
                    final widget=UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot,);
                    if(widget!=null){
                      return widget;
                    }

                    // product found
                    final products= snapshot.data!;
                    return UBrandShowcase(images: products.map((product)=> product.thumbnail).toList(),brand: brand);
                  }
              );
            }
        );
      }
    );
          


  }
}
