import 'dart:convert';

import 'package:e_commerce/data/repository/authentication_repository.dart';
import 'package:e_commerce/data/repository/product/product_repository.dart';
import 'package:e_commerce/features/shopping/models/product_model.dart';
import 'package:e_commerce/utils/popups/snackbar_helpers.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FavouriteController extends GetxController{

  static FavouriteController get instance => Get.find();
  /// variables
  /// only favourite (true values ) are stored in this map
  RxMap<String, bool> favourites= <String,bool>{}.obs;
  // local storage
  final _storage=GetStorage(AuthenticationRepository.instance.currentUser!.uid);

  @override
  void onInit() {
    // initialize favourites variable with the value of _storage
    initFavourites();
    // TODO: implement onInit
    super.onInit();
  }

  // implement initFavourites function
  // for initialize favourites map by reading local storage
  Future<void> initFavourites() async{
   String? encodedFavourites=  _storage.read('favourites');
   if(encodedFavourites==null) return ;
   Map<String, dynamic> storedFavourites= jsonDecode(encodedFavourites) as Map<String, dynamic>;
   favourites.assignAll(storedFavourites.map((key,value)=> MapEntry(key, value as bool)));


  }

  /// method for toggling favourite product
  void toggleFavouriteProduct(String productId){
     if(favourites.containsKey(productId)){
       favourites.remove(productId);
       saveFavouritesToStorage();
       USnackBarHelpers.customToast(message: 'Product has been removed from the Wishlist');
     }else{
       favourites[productId]=true;
       saveFavouritesToStorage();
       USnackBarHelpers.customToast(message: 'Product has been added to the Wishlist');
     }
  }

  /// save favourites into the _storage(local storage)
  void saveFavouritesToStorage(){
    // getStorage can not able to save map , so what to encode it to convert a encoded string and string is allow to store directly
    String encodedFavourites= jsonEncode(favourites);
    _storage.write('favourites', encodedFavourites);
  }

  /// for checking favourite or not
  bool isFavourite(String productId){
    return favourites.containsKey(productId);
  }

  /// function to get favourite products
  Future<List<ProductModel>> getFavouriteProducts() async{
   List<String> productsIds= favourites.keys.toList();

   /// get those product from fire store
   List<ProductModel> favouriteProducts= await ProductRepository.instance.fetchFavouriteProducts(productsIds);
   return favouriteProducts;
  }

}