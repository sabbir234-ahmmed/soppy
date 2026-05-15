import 'package:e_commerce/common/widgets/brands/brand_showcase.dart';
import 'package:e_commerce/common/widgets/layouts/grid_layout.dart';
import 'package:e_commerce/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:e_commerce/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/features/shopping/controllers/category/category_controller.dart';
import 'package:e_commerce/features/shopping/models/category_model.dart';
import 'package:e_commerce/features/shopping/models/product_model.dart';
import 'package:e_commerce/features/shopping/screens/all_products/all_products.dart';
import 'package:e_commerce/features/shopping/screens/store/widgets/category_brands.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UCategoryTab extends StatelessWidget {
  const UCategoryTab({super.key, required this.category});
  ///variables
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final categoryController=CategoryController.instance;

    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: USizes.defaultSpace),
          child: Column(
            children: [

              /// brand showcase of category
              CategoryBrands(category: category,),

              /// You might like section heading
              SizedBox(height: USizes.spaceBtwItems),
              USectionHeading(title: "You might like",
                onPressed: ()=>
                    Get.to(()=>AllProductsScreen(
                        futureMethod: categoryController.getCategoryProduct(categoryId: category.id,limit: -1),
                        title: category.name)
                    ),
                showButton: true,),

              ///product gridview
              FutureBuilder(
                future: categoryController.getCategoryProduct(categoryId: category.id),
                builder: (context, snapshot) {

                  const loader= UVerticalProductShimmer(itemCount: 4,);
                  // handle error, loading , state
                  final widget= UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot,loader: loader);
                  if(widget!=null){
                    return widget;
                  }
                  // has record
                  final List<ProductModel> products= snapshot.data!;

                  return UGridLayout(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return UProductCardVertical(product: products[index] ,);
                    },
                  );
                }
              ),

              /// default space between section
              SizedBox(height: USizes.spaceBtwSections,),
            ],
          ),
        ),
      ],
    );
  }
}
