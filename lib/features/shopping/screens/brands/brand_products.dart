import 'package:e_commerce/common/styles/padding.dart';
import 'package:e_commerce/common/widgets/appbar/appbar.dart';
import 'package:e_commerce/common/widgets/brands/brand_card.dart';
import 'package:e_commerce/common/widgets/products/sortable_products.dart';
import 'package:e_commerce/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:e_commerce/features/shopping/controllers/brand/brand_controller.dart';
import 'package:e_commerce/features/shopping/models/brands_model.dart';
import 'package:e_commerce/features/shopping/models/product_model.dart';

import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';


class BrandProductsScreen extends StatelessWidget {
  const BrandProductsScreen({super.key, required this.title, required this.brand});

  final String title;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final brandController=BrandController.instance;
    return  Scaffold(
      /// -----[App Bar]------
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(title, style: Theme.of(context).textTheme.headlineMedium,),

      ),

      /// -----[Body]------
      body: SingleChildScrollView(
        child: Padding(
          padding:  UPadding.screenPadding,
          child: Column(
            children: [
              /// brand card
              UBrandCard(brand: brand,),
              ///space btw section
              SizedBox(height: USizes.spaceBtwSections,),
              /// sortable brand product
              FutureBuilder(
                future: brandController.getBrandProducts(brand.id),
                builder: (context, snapshot) {
                  /// handle future builder state( loading , error, empty)??
                  const loader= UVerticalProductShimmer();
                  Widget? widget= UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                  if(widget!=null){
                    return widget;
                  }
                  //data found
                  List<ProductModel> brandProducts=snapshot.data!;
                  return USortableProducts(products: brandProducts);
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
