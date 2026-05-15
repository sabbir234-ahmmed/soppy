import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/features/shopping/models/product_model.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageController extends GetxController{
  static ImageController get instance=>Get.find();

  /// variables
  RxString selectedProductImage=''.obs;

  //[Function for Load all images of a single product into a List]------------
  // no duplicate
  List<String> getAllProductImages(ProductModel product){
    Set<String> images={};

    //load thumbnail image inside list
    images.add(product.thumbnail);

    // assign thumbnail as selected image
    selectedProductImage.value=product.thumbnail;

    // load all images of product inside the list
    if(product.images!=null && product.images!.isNotEmpty){
      images.addAll(product.images!);
    }

    // load all images from this product variation
    if(product.productVariations!=null && product.productVariations!.isNotEmpty){
      List<String> variationImages=product.productVariations!.map((variation)=> variation.image).toList();

      // initialize images list
      images.addAll(variationImages);
    }
    return images.toList();
  }

  // function to show image in full screen
  void showEnlargeImage(String image){
    Get.to(
      fullscreenDialog: true,
        ()=> Dialog.fullscreen(
          child: Column(
            children: [

              /// show image
              Padding(
                  padding: EdgeInsets.symmetric(vertical: USizes.defaultSpace*2, horizontal: USizes.defaultSpace),

                  child: CachedNetworkImage(imageUrl: image),
              ),

              /// space
              SizedBox(height: USizes.spaceBtwSections,),

              /// Close button
              Align(
                alignment: Alignment.bottomCenter,

                child: SizedBox(
                  width: 150,
                  child: OutlinedButton(
                      onPressed: ( ){
                        Get.back();
                      },
                      child: Text("Close"),
                  ),
                ),
              )
            ],
          )
        )
    );
  }
}