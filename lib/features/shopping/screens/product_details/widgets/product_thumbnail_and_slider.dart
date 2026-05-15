import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/common/widgets/appbar/appbar.dart';
import 'package:e_commerce/common/widgets/icons/circular_icon.dart';
import 'package:e_commerce/common/widgets/images/rounded_image.dart';
import 'package:e_commerce/common/widgets/products/favourite/favourite_icon.dart';
import 'package:e_commerce/features/shopping/controllers/product/image_controller.dart';
import 'package:e_commerce/features/shopping/models/product_model.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UProductThumbnailAndSlider extends StatelessWidget {
  const UProductThumbnailAndSlider({
    super.key, required this.product,
  });

  ///variables
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    /// image controller
    final imageController=Get.put(ImageController());
    final dark= UHelperFunction.isDarkMode(context);
    // assign all images of this product
    List<String> images=imageController.getAllProductImages(product);

    return Container(
      color: dark ? UColors.darkerGrey : UColors.light ,
      child: Stack(
        children: [

          ///image - thumbnail
          SizedBox(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(USizes.productImageRadius * 2),
              child: Center(child: Obx(
                ( ){
                  final image =imageController.selectedProductImage.value;
                  return GestureDetector(
                     onTap: (){
                       imageController.showEnlargeImage(image);
                     },
                     child: CachedNetworkImage(
                      imageUrl: image,
                      progressIndicatorBuilder: (context, url, progress){
                        return CircularProgressIndicator(color: UColors.primary,value: progress.progress,);
                      },
                    ),
                  );
                }
              )),
            ),
          ),

          ///image slider
          Positioned(
            left: USizes.defaultSpace,
            right: 0,
            bottom: 30,

            child: SizedBox(
              height: 80,
              child: ListView.separated(
                  separatorBuilder: (context,index)=>SizedBox(width: USizes.spaceBtwItems,),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (context,index){
                    return Obx(
                      ( ){
                        final isSelected=imageController.selectedProductImage.value == images[index]? true: false;

                        return URoundedImage(
                          isNetworkImage: true,
                          imageUrl: images[index],
                          onTap: (){
                            imageController.selectedProductImage.value=images[index];
                          },
                          width: 80,
                          backgroundColor: dark? UColors.dark: UColors.white,
                          padding: EdgeInsets.all(USizes.sm),
                          border: isSelected? Border.all(color: UColors.primary): null,

                        );
                      }
                    );
                  }
              ),
            ),
          ),

          /// back arrow and heart
          UAppBar(
            showBackArrow: true,
            actions: [
              UFavouriteIcon(productId: product.id,),
            ],
          )

        ],
      ),
    );
  }
}