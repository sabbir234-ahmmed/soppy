import 'package:e_commerce/common/styles/padding.dart';

import 'package:e_commerce/common/widgets/button/elevated_button.dart';

import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/features/shopping/controllers/card/cart_controller.dart';
import 'package:e_commerce/features/shopping/models/product_model.dart';
import 'package:e_commerce/features/shopping/screens/product_details/widgets/bottom_add_to_card.dart';
import 'package:e_commerce/features/shopping/screens/product_details/widgets/product_attributes.dart';
import 'package:e_commerce/features/shopping/screens/product_details/widgets/product_meta_data.dart';
import 'package:e_commerce/features/shopping/screens/product_details/widgets/product_thumbnail_and_slider.dart';
import 'package:e_commerce/utils/constants/enums.dart';
import 'package:e_commerce/utils/constants/sizes.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:readmore/readmore.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});

  /// variables
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final cartController= Get.put(CartController());

    return Scaffold(
      ///------body--------
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// product Images with Slider
            UProductThumbnailAndSlider(product: product),

            Padding(
              padding: UPadding.screenPadding,
              child: Column(
                children: [
                  /// ---- product Details-------
                  //price, title, stock and brand
                  UProductMetaData(product: product),
                  ///space
                  SizedBox(height: USizes.spaceBtwItems,),
                  ///product attributes
                  /// show if product has a variations
                  if(product.productType==ProductType.variable.toString() )...[
                       UProductAttributes(product: product,),
                      ///space
                       SizedBox(height: USizes.spaceBtwSections,),
                    ],




                  /// checkout button
                  UElevatedButton(
                    onPressed: (){},
                    child: Text("Check Out"),
                  ),

                  ///space
                  SizedBox(height: USizes.spaceBtwItems,),

                  /// description
                  USectionHeading(title: "Description", showButton: false,),

                  ///space
                  SizedBox(height: USizes.spaceBtwItems,),

                  /// read more description
                  ReadMoreText(
                    product.description ?? '',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: "Show more",
                    trimExpandedText: "Less",
                    moreStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w800 ),
                    lessStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w800 ),

                  ),

                  ///space
                  SizedBox(height: USizes.spaceBtwSections,),

                ],
              ),
            )

          ],
        ),
      ),

      /// -----bottom navigation------
      bottomNavigationBar: UBottomAddToCart(product: product,),

    );
  }
}




