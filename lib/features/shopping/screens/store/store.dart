
import 'package:e_commerce/common/widgets/appbar/tabbar.dart';
import 'package:e_commerce/common/widgets/brands/brand_card.dart';
import 'package:e_commerce/common/widgets/shimmer/brands_shimmer.dart';
import 'package:e_commerce/common/widgets/shimmer/shimmer_effect.dart';
import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/features/shopping/controllers/brand/brand_controller.dart';
import 'package:e_commerce/features/shopping/controllers/category/category_controller.dart';
import 'package:e_commerce/features/shopping/models/brands_model.dart';
import 'package:e_commerce/features/shopping/screens/brands/all_brands.dart';
import 'package:e_commerce/features/shopping/screens/brands/brand_products.dart';

import 'package:e_commerce/features/shopping/screens/store/widgets/category_tab.dart';
import 'package:e_commerce/features/shopping/screens/store/widgets/store_primary_header.dart';

import 'package:e_commerce/utils/constants/sizes.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});



  @override
  Widget build(BuildContext context) {
    /// brand controller
    final brandController= Get.put(BrandController());
  // controller
    final controller =CategoryController.instance;

    return DefaultTabController(
      length: controller.featuredCategories.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: 340,
                pinned: true,
                floating: false,
                flexibleSpace: SingleChildScrollView(
                  child: Column(
                    children: [
                      ///store primary header
                      UStorePrimaryHeader(),
                        
                      ///space btw item
                      SizedBox(height: USizes.spaceBtwItems),
                        
                      ///brand heading and brand card
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: USizes.defaultSpace),
                        child: Column(
                          children: [
                            /// section heading
                            USectionHeading(
                              title:"Brand",
                              onPressed: (){
                                Get.to(BrandsScreen());
                              },
                              showButton: true,
                            ),

                            /// brand rounded card
                            SizedBox(
                              height: USizes.brandCardHeight,
                              child: Obx(
                                  ( ){

                                    // if brand loading
                                    if(brandController.isBrandsLoading.value){
                                      return UBrandsShimmer();
                                    }

                                    // if empty
                                    if(brandController.featuredBrands.isEmpty){
                                      return Text("Brand Not Found");
                                    }

                                    return ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: brandController.featuredBrands.length,
                                      separatorBuilder: (context, index) {
                                        return SizedBox(width:USizes.spaceBtwItems);
                                      },

                                      itemBuilder:(context, index) {
                                        BrandModel brand=brandController.featuredBrands[index];
                                        return SizedBox(
                                          width:  USizes.brandCardWidth,
                                          child: UBrandCard(brand: brand,
                                            onTap: (){
                                            Get.to(BrandProductsScreen(title: brand.name, brand: brand));
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  }
                              ),
                            ),
                          ],
                        ),
                      )
                        
                    ],
                  ),
                ),

                ///for tabbar
                bottom: UTabBar(
                    tabs: controller.featuredCategories.map((category)=> Tab(child: Text(category.name))).toList(),
                ),

              ),
            ];
          },
          body: TabBarView(
              children:  controller.featuredCategories.map((category)=> UCategoryTab(category: category,)).toList(),
          ),
        ),
      ),
    );
  }
}










