

import 'package:e_commerce/common/styles/padding.dart';
import 'package:e_commerce/common/widgets/appbar/appbar.dart';
import 'package:e_commerce/common/widgets/brands/brand_card.dart';
import 'package:e_commerce/common/widgets/layouts/grid_layout.dart';
import 'package:e_commerce/common/widgets/shimmer/brands_shimmer.dart';

import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/features/shopping/controllers/brand/brand_controller.dart';
import 'package:e_commerce/features/shopping/models/brands_model.dart';
import 'package:e_commerce/features/shopping/screens/brands/brand_products.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// brandController
    final brandController= BrandController.instance;
    return  Scaffold(
      /// -----[ App Bar]-----
      appBar: UAppBar(
        showBackArrow: true,
        title: Text("Brands", style: Theme.of(context).textTheme.headlineMedium,),

      ),

      /// -----[body part]------
      // brand card
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///brand title
              USectionHeading(title:" Brand", showButton: false,),
              SizedBox(height: USizes.spaceBtwItems,),
              // brand card grid view
              Obx(
                  () {
                    // if brand loading
                    if(brandController.isBrandsLoading.value){
                      return UBrandsShimmer();
                    }

                    // if empty
                    if(brandController.featuredBrands.isEmpty){
                      return Text("Brand Not Found");
                    }

                    return UGridLayout(
                        mainAxisExtent: 80,
                        itemCount: brandController.allBrands.length,
                        itemBuilder: (context, index){
                          BrandModel brand= brandController.allBrands[index];
                          return UBrandCard(onTap: ()=> Get.to( ()=>BrandProductsScreen(title: brand.name, brand: brand,)) ,brand: brand,);
                        }
                    );
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
