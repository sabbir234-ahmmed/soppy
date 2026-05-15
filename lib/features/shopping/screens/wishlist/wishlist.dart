
import 'package:e_commerce/common/widgets/appbar/appbar.dart';
import 'package:e_commerce/common/widgets/icons/circular_icon.dart';
import 'package:e_commerce/common/widgets/layouts/grid_layout.dart';
import 'package:e_commerce/common/widgets/loaders/animation_loader.dart';
import 'package:e_commerce/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:e_commerce/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:e_commerce/features/shopping/controllers/product/favourite_controller.dart';
import 'package:e_commerce/features/shopping/models/product_model.dart';

import 'package:e_commerce/navigation_menu.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favouriteController= FavouriteController.instance;

    return Scaffold(
      /// for Heading (wishlist) and  add icon
      appBar: UAppBar(
        title: Text(
          "Wishlist",
          style:Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          UCircularIcon(
              icon:Iconsax.add,
               onPressed: (){
                NavigationController.instance.selectedIndex.value = 0;
               },
          ),
        ],

      ),
      ///end


      ///body section .... vertical product cards
      body: SingleChildScrollView(
        padding: EdgeInsets.all(USizes.defaultSpace),
        child: Obx(
            ()=> FutureBuilder(
            future: favouriteController.getFavouriteProducts(),
            builder: (context, snapshot) {
              final nothingFound= UAnimationLoader(animation:UImages.pencilAnimation,text: 'Wishlist is Empty');
              const loader= UVerticalProductShimmer();
              /// state, error, empty data handle
              final widget=UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot,loader: loader, nothingFound:nothingFound );
              if(widget!=null){
                return widget;
              }
              // product found
              List<ProductModel>favouriteProducts=snapshot.data!;
              return UGridLayout(
                  itemCount: favouriteProducts.length,
                  itemBuilder: (context,index){
                    return UProductCardVertical(product: favouriteProducts[index],);
                  }
              );
            }
          ),
        ),
      ),
      ///end.....

    );
  }
}
