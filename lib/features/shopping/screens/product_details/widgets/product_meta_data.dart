
import 'package:e_commerce/common/widgets/custom_shapes/rounded_container.dart';
import 'package:e_commerce/common/widgets/images/circular_image.dart';
import 'package:e_commerce/common/widgets/texts/brand_title_with_verify_icon.dart';
import 'package:e_commerce/common/widgets/texts/product_price_text.dart';
import 'package:e_commerce/common/widgets/texts/product_title_text.dart';
import 'package:e_commerce/features/shopping/controllers/product/product_controller.dart';
import 'package:e_commerce/features/shopping/models/product_model.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/enums.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UProductMetaData extends StatelessWidget {
  const UProductMetaData({
    super.key, required this.product,
  });

  /// variables
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    // product controller
    final productController=ProductController.instance;
    String? salePercentage= productController.calculateSalePercentage(product.price, product.salePrice);
    return  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // sale tag, prices, share icon
          Row(
            children: [
              //sale tag / discount tag
              if(salePercentage!=null)...[
                URoundedContainer(
                  radius: USizes.sm,
                  backgroundColor: UColors.yellow.withValues(alpha: 0.8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: USizes.sm,
                    vertical: USizes.xs,
                  ),
                  child: Text(
                    "$salePercentage%",
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge!.apply(color: UColors.black),
                  ),
                ),


                SizedBox(width: USizes.spaceBtwItems,),
              ],

              /// actual price
              if(product.productType==ProductType.single.toString() && product.salePrice>0.0)...[
                Text("${UTexts.currency}${product.price}", style: Theme.of(context).textTheme.titleSmall!.apply(decoration: product.salePrice!=0 ?TextDecoration.lineThrough: null),),
                SizedBox(width: USizes.spaceBtwItems,),
              ],
              
              ///sale price or actual price
              UProductPriceText(price:productController.getProductPrice(product), isLarge: true,),
              Spacer(),
              //share icon
              IconButton(
                onPressed: (){},
                icon: Icon(Icons.share),
              )
            ],
          ),
          SizedBox(height: USizes.spaceBtwItems / 1.5,),
          //product title
          UProductTitleText(title:product.title,),
          SizedBox(height: USizes.spaceBtwItems / 1.5,),

          // status and stock
          Row(
            children: [
              //status
              UProductTitleText(title:"Status:"),
              SizedBox(width: USizes.spaceBtwItems,),
              // stock
              Text(productController.getProductStockStatus(product.stock), style: Theme.of(context).textTheme.titleMedium,),

            ],
          ),
          SizedBox(height: USizes.spaceBtwItems / 1.5,),

          //brand image, brand name and tick mark(icon)
          Row(
            children: [
              //brand image
              UCircularImage(image:product.brand!=null ? product.brand!.image:'',isNetworkImage: true,),
              SizedBox(width: USizes.spaceBtwItems,),
              //title with verify icon
              UBrandTitleWithVerifyIcon(title:product.brand!=null ? product.brand!.name: ''),

            ],
          ),

        ],
      );

  }
}