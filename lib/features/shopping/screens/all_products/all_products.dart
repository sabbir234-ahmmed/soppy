import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/common/styles/padding.dart';
import 'package:e_commerce/common/widgets/appbar/appbar.dart';

import 'package:e_commerce/common/widgets/products/sortable_products.dart';
import 'package:e_commerce/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:e_commerce/features/shopping/controllers/product/all_products_controller.dart';
import 'package:e_commerce/features/shopping/models/product_model.dart';
import 'package:e_commerce/utils/helpers/cloud_helper_functions.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key, required this.futureMethod, this.query, required this.title});

  /// variables
  final Future<List<ProductModel>>? futureMethod;
  final Query? query;

  final String title;

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(AllProductsController());
    
    return Scaffold(
      ///------- app bar-------------
      appBar: UAppBar(
      showBackArrow: true,
      title: Text(title, style: Theme.of(context).textTheme.headlineMedium,),
    ),

      ///--------[ body]-----------
      body: SingleChildScrollView(
        child: Padding(
            padding: UPadding.screenPadding,
            child:   FutureBuilder(
              future: futureMethod ?? controller.fetchproductByQuery(query),
              builder: (context,  snapshot) {
                const loader= UVerticalProductShimmer();
                final widget= UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                if(widget!=null){
                  return widget;
                }
                final products=snapshot.data!;
                return USortableProducts(products: products);
              }
            ),
        ),
      ),

    );
  }
}


