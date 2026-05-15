import 'package:e_commerce/common/widgets/icons/circular_icon.dart';
import 'package:e_commerce/features/shopping/controllers/product/favourite_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UFavouriteIcon extends StatelessWidget {
  const UFavouriteIcon({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    final favouriteController=Get.put(FavouriteController());

    return  Obx(
      ( )=> UCircularIcon(
        icon: favouriteController.isFavourite(productId) ?Iconsax.heart5: Iconsax.heart,
        color:  favouriteController.isFavourite(productId) ?Colors.red :null ,
        onPressed: ()=> favouriteController.toggleFavouriteProduct(productId),
      ),
    );
  }
}
