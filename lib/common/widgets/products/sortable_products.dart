import 'package:e_commerce/common/widgets/layouts/grid_layout.dart';
import 'package:e_commerce/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:e_commerce/features/shopping/controllers/product/all_products_controller.dart';
import 'package:e_commerce/features/shopping/models/product_model.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class USortableProducts extends StatelessWidget {
  const USortableProducts({
    super.key, required this.products,
  });

  ///variables
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(AllProductsController());
    controller.assignProduct(products);

    return Column(
      children: [
        /// filter field
        DropdownButtonFormField(
          initialValue: controller.selectedSortOption.value,
          decoration: InputDecoration(
            prefixIcon: Icon(Iconsax.sort),
          ),
          onChanged: (value)=>controller.sortProducts(value!),
          items: ["Name", "Lower Price", "Higher Price", "Sale", "Newest"].map((filter) {
            return DropdownMenuItem(value: filter,child: Text(filter),);
          },).toList(),
        ),
        ///space
        SizedBox(height: USizes.spaceBtwItems,),
        /// Product card vertical grid view
        Obx(
          ( )=> UGridLayout(
              itemCount: controller.products.length,
              itemBuilder: (context, index){
                return UProductCardVertical(product:controller.products[index]);
              }
          ),
        ),
      ],
    );
  }
}