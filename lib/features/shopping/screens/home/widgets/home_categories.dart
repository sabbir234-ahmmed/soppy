import 'package:e_commerce/common/widgets/image_text/vertical_image_text.dart';
import 'package:e_commerce/common/widgets/shimmer/category_shimmer.dart';
import 'package:e_commerce/features/shopping/controllers/category/category_controller.dart';
import 'package:e_commerce/features/shopping/models/category_model.dart';
import 'package:e_commerce/features/shopping/screens/sub_category/sub_category.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UHomeCategories extends StatelessWidget {
  const UHomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    // category controller
    final  controller=Get.put(CategoryController());

    return Padding(
      padding: const EdgeInsets.only(left: USizes.spaceBtwSections),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// section Heading
          Text(
            UTexts.popularCategories,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium!.copyWith(color: UColors.white),
          ),
          //space
          SizedBox(height: USizes.spaceBtwItems / 2),

          /// categories list
          Obx(
            (){
              final categories= controller.featuredCategories;
              /// categories loading ???
              /// [loadingState]---------
              if(controller.isCategoriesLoading.value){
                // render shimmer effect
                return UCategoryShimmer(itemCount: categories.length);
              }

              /// categories empty???
              if(categories.isEmpty){
                return Text("Categories Not Found");
              }

              /// if categories exist

              return SizedBox(
                height: 80,
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      SizedBox(width: USizes.spaceBtwItems),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    CategoryModel category= categories[index];
                    return UVerticalImageText(
                      image: category.image ,
                      title: category.name,
                      textColor: UColors.white,

                      onTap: (){
                        Get.to(SubCategoryScreen(category: category));
                      },
                    );
                  },
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}
