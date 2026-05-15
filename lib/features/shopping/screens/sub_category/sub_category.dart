import 'package:e_commerce/common/styles/padding.dart';
import 'package:e_commerce/common/widgets/appbar/appbar.dart';

import 'package:e_commerce/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:e_commerce/common/widgets/shimmer/horizontal_product_shimmer.dart';
import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/features/shopping/controllers/category/category_controller.dart';
import 'package:e_commerce/features/shopping/models/category_model.dart';
import 'package:e_commerce/features/shopping/models/product_model.dart';
import 'package:e_commerce/features/shopping/screens/all_products/all_products.dart';

import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/cloud_helper_functions.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SubCategoryScreen extends StatelessWidget {
  const SubCategoryScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final bool dark = UHelperFunction.isDarkMode(context);
    final categoryController=  CategoryController.instance;

    return  Scaffold(
        ///-------[app bar]-------
        appBar: UAppBar(
          showBackArrow: true,
          title: Text(category.name,style: Theme.of(context).textTheme.headlineSmall,) ,
        ),

        ///------[ body]----------
        body: SingleChildScrollView(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              /// fetch sub categories
             FutureBuilder(
                 future: categoryController.getSubCategories(category.id),
                 builder: (context, snapshot){
                   // state , error and empty data handling
                   const loader= UHorizontalProductShimmer();
                   final widget= UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                    if(widget!=null){
                      return widget;
                    }

                    /// data found
                   List<CategoryModel> subCategories = snapshot.data!;
                   return ListView.builder(
                     shrinkWrap: true,
                       physics: NeverScrollableScrollPhysics(),
                       itemCount: subCategories.length,
                       itemBuilder: (context, index){
                         CategoryModel subCategory= subCategories[index];
                         
                         /// fetch product for sub category
                         return FutureBuilder(
                           future:categoryController.getCategoryProduct(categoryId:subCategory.id),
                           builder: (context, snapshot) {
                             // state , error and empty data handling
                             const loader= UHorizontalProductShimmer();
                             final widget = UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                             if(widget!=null){
                               return widget;
                             }
                             /// data found
                             List<ProductModel> categoryProducts = snapshot.data!;
                             return Column(
                               children: [
                                 /// ----------[ SUB CATEGORY ]---------------

                                 /// section heading
                                 USectionHeading(
                                   title: subCategory.name,
                                   onPressed: (){
                                     final futureMethod= categoryController.getCategoryProduct(categoryId:subCategory.id,limit: -1);
                                    Get.to(AllProductsScreen(futureMethod: futureMethod, title: subCategory.name));
                                   },
                                 ),
                                 //space
                                 SizedBox(height: USizes.spaceBtwItems,),

                                 /// Horizontal product card
                                 SizedBox(
                                   height: 120 ,
                                   child: ListView.separated(
                                     itemCount: categoryProducts.length,
                                     scrollDirection: Axis.horizontal,
                                     itemBuilder: (context, index){
                                       ProductModel categoryProduct=categoryProducts[index];
                                       return UProductCardHorizontal(
                                         categoryProduct: categoryProduct ,

                                       );
                                     },
                                     separatorBuilder: (BuildContext context, int index) {
                                       return SizedBox(width: USizes.spaceBtwItems,);
                                     },
                             
                             
                                   ),
                                 ),
                               ],
                             );
                           }
                         );
                       }
                   );

                 }
             ),

            ],
          ),
        ),
    );
  }
}


