
import 'package:e_commerce/common/widgets/layouts/grid_layout.dart';
import 'package:e_commerce/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:e_commerce/common/widgets/textfields/search_bar.dart';
import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/features/shopping/controllers/home/home_controller.dart';
import 'package:e_commerce/common/widgets/custom_shapes/primary_header_container.dart';
import 'package:e_commerce/features/shopping/controllers/product/product_controller.dart';
import 'package:e_commerce/features/shopping/screens/all_products/all_products.dart';
import 'package:e_commerce/features/shopping/screens/home/widgets/home_appbar.dart';
import 'package:e_commerce/features/shopping/screens/home/widgets/home_categories.dart';
import 'package:e_commerce/features/shopping/screens/home/widgets/promo_slider.dart';

import 'package:e_commerce/utils/constants/images.dart';
import 'package:e_commerce/utils/constants/sizes.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //controller  variable
    final controller= Get.put(HomeController());
    final productController=Get.put(ProductController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// upper part appbar,categories list and search bar
            Stack(
              children: [
                ///Transparent Container
                SizedBox(height: USizes.homePrimaryHeaderHeight + 10),
        
                /// primary header container
                UPrimaryHeaderContainer(
                  height: USizes.homePrimaryHeaderHeight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///AppBar
                      UHomeAppBar(),
                      //space
                      SizedBox(height: USizes.spaceBtwSections),
        
                      /// Home page's categories
                      UHomeCategories(),
                    ],
                  ),
                ),
        
                ///search bar
                USearchBar(),
              ],
            ),
        
            ///lower part
            //banners
            Padding(
              padding: const EdgeInsets.all(USizes.defaultSpace / 2),
              child: Column(
                children: [
                  //banner and dot navi
                  UPromoSlider(),
        
                  //sapce
                  SizedBox(height: USizes.spaceBtwSections,),
                  ///section Heading
                  USectionHeading(title: "Popular Products",
                    onPressed: (){
                      Get.to(AllProductsScreen(
                        futureMethod: productController.getAllFeaturedProducts(),
                        title: "Popular Products",
                      ));
                    },
                    showButton: true,
                  ),
        
                  //space
                  SizedBox(height: USizes.spaceBtwItems),
        
                  /// Grid view of Vertical Products card
                  Obx(
                   ( ){
                     if(productController.isLoading.value){
                       return CircularProgressIndicator();
                     }

                     if(productController.featuredProducts.isEmpty){
                       return Center(child: Text("Products Not Found"),);
                     }
                     return UGridLayout(
                       itemCount: productController.featuredProducts.length,
                       itemBuilder: (context, index) {
                         return UProductCardVertical(product: productController.featuredProducts[index],);
                       },
                     );
                   }
                  )
        
                ],
              ),
            ),
        
        
          ],
        ),
      ),
    );
  }
}









