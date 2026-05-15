import 'package:e_commerce/features/shopping/controllers/card/cart_controller.dart';
import 'package:e_commerce/features/shopping/controllers/product/image_controller.dart';
import 'package:e_commerce/features/shopping/models/product_model.dart';
import 'package:e_commerce/features/shopping/models/product_variation_model.dart';
import 'package:get/get.dart';

class VariationController extends GetxController{
  static VariationController get instance =>Get.find();

  ///variables
  RxMap selectedAttributes={}.obs;
  Rx<ProductVariationModel> selectedVariation=ProductVariationModel.empty().obs;
  RxString selectedVariationStockStatus=''.obs;


  // function for store selected attributes
  //invoke when select attributes and variation
  void onAttributeSelected(ProductModel product, attributeName, attributeValue){
    Map<String,dynamic> selectedAttributes= Map<String,dynamic>.from(this.selectedAttributes);
    //apply logic
    selectedAttributes[attributeName]=attributeValue;
    this.selectedAttributes[attributeName]=attributeValue;

    //get selected variation
    ProductVariationModel selectedVariation= product.productVariations!.firstWhere((variation)=> isSameAttributeValue(variation.attributeValues, selectedAttributes), orElse: ()=> ProductVariationModel.empty());

    // initialize selectedProductImage as selected variation
    // for showing selected product image as a main image
    if(selectedVariation.image.isNotEmpty){
      ImageController.instance.selectedProductImage.value=selectedVariation.image;
    }

    // initialize item count according to curr product
    if(selectedVariation.id.isNotEmpty){
      final cartController= CartController.instance;
      cartController.productQuantityInCart.value=cartController.getVariationQuantityInCart(product.id, selectedVariation.id);
    }

    // initialize this.selectedVariation as selectedVariation
    this.selectedVariation(selectedVariation);
    getSelectedVariationStockStatus();

  }

  /// function to determine is same attributes or not??
  bool isSameAttributeValue(Map<String,dynamic>variationAttributes, Map<String, dynamic>selectedAttributes){
     // if selected attributes contain 3 attribute but the current variation have 2 attributes then return
     // no match
    if(variationAttributes.length != selectedAttributes.length){
      return false;
    }

    //if any of the attribute differ then return
    //no match
    for(final key in variationAttributes.keys){
      if(variationAttributes[key]!= selectedAttributes[key]){
        // no match
        return false;
      }
    }

    return true;
  }

  /// function to determine availability of attributes in variations
  /// check selected variation is available in the variations??
  /// and get the available attributes list
 Set<String?> getAttributesAvailabilityInVariations(List<ProductVariationModel> variations, String attributeName){
    // pass the variation to check which attributes are available and stock is not 0
    final availableAttributesValues= variations.where((variation)=> variation.attributeValues[attributeName]!.isNotEmpty && variation.attributeValues[attributeName]!=null && variation.stock >0).map((variation)=> variation.attributeValues[attributeName]).toSet();
    return availableAttributesValues ;
  }

  // variation stock status measurement and assign function
  void getSelectedVariationStockStatus(){
    selectedVariationStockStatus.value= selectedVariation.value.stock >0 ? "In Stock" : "Out of stock";
  }


  // return variation sale price
  String getVariationPrice(){
    return (selectedVariation.value.salePrice >0 ? selectedVariation.value.salePrice: selectedVariation.value.price).toStringAsFixed(0);
  }


  /// method for resetting selectedAttributes , when switching products
  void resetSelectedAttributes(){
    selectedAttributes.clear();
    selectedVariationStockStatus.value='';
    selectedVariation.value=ProductVariationModel.empty();
  }


/// end
}