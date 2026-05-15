
import 'package:e_commerce/data/repository/brands/brands_repository.dart';
import 'package:e_commerce/data/repository/product/product_repository.dart';
import 'package:e_commerce/features/shopping/models/brands_model.dart';
import 'package:e_commerce/features/shopping/models/product_model.dart';
import 'package:e_commerce/utils/popups/snackbar_helpers.dart';
import 'package:get/get.dart';

class BrandController extends GetxController{
  static BrandController get instance =>Get.find();


  /// variables
  final _repository=Get.put(BrandRepository());
  RxList<BrandModel> allBrands=<BrandModel> [].obs;
  RxList<BrandModel> featuredBrands=<BrandModel> [].obs;
  RxBool isBrandsLoading=false.obs;


  @override
  void onInit() {
    super.onInit();
    getBrands();
  }

  /// get  all brands and featured brands
  Future<void> getBrands() async{
    try{
      // st loading
      isBrandsLoading.value=true;

     List<BrandModel> allBrands =await _repository.fetchBrand();
     this.allBrands.assignAll(allBrands);

     featuredBrands.assignAll(allBrands.where((brand)=> brand.isFeatured?? false).toList());

    }catch(e){
      USnackBarHelpers.errorSnackBar(title: "Failed to Get Brand",message: e.toString());
    }finally{
      isBrandsLoading.value=false;
    }
  }


  /// get brand's specific products
  Future<List<ProductModel>> getBrandProducts(String brandId, { int limit=-1}) async{
    try{
      List<ProductModel> brandProducts= await ProductRepository.instance.getProductsForBrand(brandId: brandId, limit: limit );
      return brandProducts;
    }catch (e){
      USnackBarHelpers.errorSnackBar(title: "Failed", message: e.toString());
      return [];
    }
  }


  /// get brand's for specific category
  Future<List<BrandModel>> getBrandForCategory(String categoryId) async{
    try{
      List<BrandModel> brands= await _repository.fetchBrandForCategory(categoryId) ;
      return brands;
    }catch (e){
      USnackBarHelpers.errorSnackBar(title: "Failed", message: e.toString());
      return [];
    }
  }


}