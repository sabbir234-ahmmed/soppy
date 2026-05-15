import 'dart:math';

import 'package:e_commerce/data/repository/product/product_repository.dart';
import 'package:e_commerce/features/shopping/models/product_model.dart';
import 'package:e_commerce/features/shopping/models/product_variation_model.dart';
import 'package:e_commerce/utils/constants/enums.dart';
import 'package:e_commerce/utils/constants/text.dart';
import 'package:e_commerce/utils/popups/snackbar_helpers.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{
  static ProductController get instance => Get.find();

  /// variables
  final _repository= Get.put(ProductRepository());
  RxList<ProductModel> featuredProducts=<ProductModel> [].obs;
  RxBool isLoading= false.obs;


  @override
  void onInit() {
    super.onInit();
    getFeaturedProducts();
  }

  /// function to  getting only 4 featured products
  Future<void> getFeaturedProducts() async{
    try{
      // st loading
      isLoading.value=true;

       List<ProductModel> featuredProducts= await _repository.fetchFeaturedProducts();
       this.featuredProducts.assignAll(featuredProducts);
    }catch (e){
      USnackBarHelpers.errorSnackBar(title: "Failed",message: e.toString());
    }finally{
      // after fetching stop loading
      isLoading.value=false;
    }
  }

  /// function to  get all featured products
  Future<List<ProductModel>> getAllFeaturedProducts() async{
    try{

      // fetched featured products
      List<ProductModel> featuredProducts= await _repository.fetchAllFeaturedProducts();
      return featuredProducts;
    }catch (e){
      USnackBarHelpers.errorSnackBar(title: "Failed",message: e.toString());
      return [];
    }
  }

  // function for calculating percentage
  String? calculateSalePercentage(double actualPrice, double? salePrice){
    if(actualPrice<=0.0){
      return null;
    }

    if(salePrice==null || salePrice<=0.0){
      return null;
    }

    double discountAmount=(actualPrice-salePrice);
    double percentage=(discountAmount*100)/actualPrice;
    return percentage.toStringAsFixed(1);


  }

  // get product price if it's has multiple variations or not
  // get product price or range of price
  String getProductPrice(ProductModel product){
    double smallestPrice= double.infinity;
    double largestPrice= 0.0;

    /// if no variation exist then return it's sale price
    if(product.productType== ProductType.single.toString()){
      return product.salePrice>0 ? product.salePrice.toString(): product.price.toString();
    }else{
      // iterate variation and get smallest and largest price
      for(final variation in product.productVariations!){
         double variationPrice= variation.salePrice >0 ? variation.salePrice: variation.price;

         if(variationPrice> largestPrice){
           largestPrice=variationPrice;
         }

         if(variationPrice< smallestPrice){
           smallestPrice=variationPrice;
         }
      }

      /// check are largest and smallest prices equal??
      if(largestPrice == smallestPrice){
        return smallestPrice.toStringAsFixed(0);
      }else{
        return "${largestPrice.toStringAsFixed(0)}-${UTexts.currency}${smallestPrice.toStringAsFixed(0)}";
      }
    }

  }

  /// function that return product in stock or out of stock
  String getProductStockStatus(int stock){
    if(stock<=0){
      return "Stock Out";
    }
    return "In Stock";
  }
}