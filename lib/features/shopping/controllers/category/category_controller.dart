import 'package:e_commerce/data/repository/category/category_repository.dart';
import 'package:e_commerce/data/repository/product/product_repository.dart';
import 'package:e_commerce/features/shopping/models/category_model.dart';
import 'package:e_commerce/features/shopping/models/product_model.dart';
import 'package:e_commerce/utils/popups/snackbar_helpers.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController{
  static CategoryController get instance => Get.find();

  /// variables
  final _repository= Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories= <CategoryModel>[].obs;
  /// list of those categories which will be display
  RxList<CategoryModel> featuredCategories=<CategoryModel> [].obs;

  RxBool isCategoriesLoading= false.obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  /// function to get all categories and featured categories from fire store
  Future<void> fetchCategories() async{
    try{
      //loading categories
      isCategoriesLoading.value=true;

      // fetch categories
      List<CategoryModel> categories=await _repository.getAllCategories();

      // assign the rx variable with this fetches categories
      allCategories.assignAll(categories);

      // assign featured categories
      featuredCategories.assignAll(categories.where((category)=> category.isFeatured==true && category.parentId.isEmpty));

    }catch (e){
      USnackBarHelpers.errorSnackBar(title: "Failed", message: e.toString());
    }finally{
      // stop loading
      isCategoriesLoading.value=false;
    }
  }

  /// function to get products of a specific category
  Future<List<ProductModel>> getCategoryProduct({required String categoryId, int limit =4}) async{
    try{
      /// fetch  all products according to category
      final products = ProductRepository.instance.getProductsForCategory(categoryId: categoryId,limit: limit);
      return products;
      }catch (e){
      USnackBarHelpers.errorSnackBar(title: "Failed", message: e.toString());
      return [];
    }

    }

    /// Get subCategories of a category
    Future<List<CategoryModel>> getSubCategories(String categoryId ) async{
       try{
       final subCategories= await _repository.getSubCategories(categoryId);
       return subCategories;
       }catch (e){
         USnackBarHelpers.errorSnackBar(title: 'Failed', message: e.toString());
         return [];
       }
    }

  }

