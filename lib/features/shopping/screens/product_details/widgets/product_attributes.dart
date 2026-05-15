import 'package:e_commerce/common/widgets/chips/choice_chips.dart';
import 'package:e_commerce/common/widgets/custom_shapes/rounded_container.dart';
import 'package:e_commerce/common/widgets/texts/product_price_text.dart';
import 'package:e_commerce/common/widgets/texts/product_title_text.dart';
import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/features/shopping/controllers/product/variation_controller.dart';
import 'package:e_commerce/features/shopping/models/product_model.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/keys.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/text.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UProductAttributes extends StatelessWidget {
  const UProductAttributes({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    /// variation controller
    final variationController =Get.put(VariationController());

    final bool dark= UHelperFunction.isDarkMode(context);

    return  Obx(
      ( )=> Column(
        children: [
          /// Selected  Attributes pricing  & Description
          // if attributes selected then show , otherwise no
          if(variationController.selectedVariation.value.id.isNotEmpty)
          URoundedContainer(
            backgroundColor:dark ? UColors.darkerGrey: UColors.grey ,

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //variations
                children: [
                  /// title , price and stock
                  Row(
                    children: [
                      // variation heading text
                      USectionHeading(title:"Variation", showButton: false,),
                      //space
                      SizedBox(width: USizes.spaceBtwItems,),

                      Column(
                        children: [
                          /// price text, sale price, actual price
                          Row(
                            children: [
                              //price text
                            UProductTitleText(title:"Price: ", smallSize: true,),

                              //actual price
                              if(variationController.selectedVariation.value.salePrice>0.0)
                              Text("${UTexts.currency}${variationController.selectedVariation.value.price}", style: Theme.of(context).textTheme.titleSmall!.apply(decoration:  TextDecoration.lineThrough),),
                              SizedBox(width: USizes.spaceBtwItems,),
                              //if sale price is greater than 0 then show
                              //sale price
                              UProductPriceText(price:variationController.getVariationPrice()),
                            ],
                          ),
                          /// stock & status
                          Row(
                            children: [
                              //stock text
                              UProductTitleText(title: "Stock: ", smallSize: true,),
                              // stock status
                              UProductTitleText(title: variationController.selectedVariationStockStatus.value),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: USizes.spaceBtwItems,),
                  /// attributes description
                  UProductTitleText(
                    title: "${variationController.selectedVariation.value.description}"?? "",smallSize: true, maxLines: 4,),


                ],
              ),
            ),
          ),
          SizedBox(height: USizes.spaceBtwItems,),

          ///selected attributes Colors, choice chip
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  product.productAttributes!.map((attribute){
              return  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //color text
                  USectionHeading(title: attribute.name ?? '', showButton: false,),
                  SizedBox(height: USizes.spaceBtwItems /2,),
                  //choice chips
                  Obx(
                    ( )=> Wrap(
                      spacing: USizes.sm,
                      children: attribute.values!.map((attributesValue){
                        bool isSelected=variationController.selectedAttributes[attribute.name]==attributesValue;
                        // store  available attributes  among variations
                        bool available=variationController.getAttributesAvailabilityInVariations(product.productVariations!, attribute.name!).contains(attributesValue);
                        return UChoiceChip(
                          text: attributesValue,
                          selected: isSelected,
                          onSelected: available? (selected) {
                            if(available && selected){
                              variationController.onAttributeSelected(product, attribute.name, attributesValue);
                            }
                          }: null,
                        );
                      }
                      ).toList(),
                    ),
                  )
                ],
              );
            }).toList(),

          ),
          /// sizes attributes

        ],
      ),
    );
  }
}


