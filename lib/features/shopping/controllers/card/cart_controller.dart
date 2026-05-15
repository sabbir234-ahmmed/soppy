import 'package:e_commerce/data/repository/authentication_repository.dart';
import 'package:e_commerce/features/shopping/controllers/product/variation_controller.dart';
import 'package:e_commerce/features/shopping/models/cart_item_model.dart';
import 'package:e_commerce/features/shopping/models/product_model.dart';
import 'package:e_commerce/features/shopping/models/product_variation_model.dart';
import 'package:e_commerce/utils/constants/enums.dart';
import 'package:e_commerce/utils/constants/keys.dart';
import 'package:e_commerce/utils/popups/snackbar_helpers.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartController extends GetxController{
  static CartController get instance =>Get.find();


  /// variables
  // local storage
  final _storage= GetStorage(AuthenticationRepository.instance.currentUser!=null ? AuthenticationRepository.instance.currentUser!.uid : "" );

  RxInt noOfCartItems=0.obs;
  RxDouble totalCartPrice=0.0.obs;
  RxInt productQuantityInCart=0.obs;
  RxList<CartItemModel> cartItems= <CartItemModel>[].obs;

  final variationController= VariationController.instance;


  @override
  void onInit() {
    print("----------------USER ID INSIDE onInit CART CONTROLLER: ${AuthenticationRepository.instance.currentUser!.uid}------------------");
    loadCartItems();
    super.onInit();

  }

  // CartController(){
  //   loadCartItems();
  // }

  /// load cartItems from local storage
  void loadCartItems()async{
    final uid=AuthenticationRepository.instance.currentUser!.uid;
    await GetStorage.init(uid);

    List<dynamic> ? storedCartItems= _storage.read(UKeys.cartItemsKey);
    if(storedCartItems!=null){
      cartItems.assignAll(storedCartItems.map((item)=>CartItemModel.fromJson(item as Map<String,dynamic>)));
      updateCartTotals();
    }else{
      print("---------------------Storage NULL UNDER LOADER--------------------------");
    }
  }

  /// add item in the cart
  void addToCart(ProductModel product){
    // check the quantity of the product
    if(productQuantityInCart<1){
      USnackBarHelpers.customToast(message: "Select Quantity");
      return ;
    }

    // check variation of product if it is variable product
    if(product.productType==ProductType.variable.toString() && variationController.selectedVariation.value.id.isEmpty ){
     USnackBarHelpers.customToast(message: 'Select Variation');
     return ;
    }

    // check out of stock status,mange for variable as well as single product
    if(product.productType == ProductType.variable.toString() && variationController.selectedVariation.value.id.isNotEmpty){
      if(variationController.selectedVariation.value.stock<1){
        throw USnackBarHelpers.errorSnackBar(title: 'Out of stock', message: 'This product is out of stock.');

      }

    }else{
      // stock check for single product
      if(product.stock<1){
        throw USnackBarHelpers.errorSnackBar(title: 'Out of stock', message: 'This product is out of stock.');
      }
    }

    /// convert productModel to cartModel for this product
    CartItemModel selectedCartItem= convertCartItem(product, productQuantityInCart.value);

    // check whether the cartItem has already added to cart or not??
    int index= cartItems.indexWhere((currItem)=> currItem.productId == selectedCartItem.productId &&  currItem.variationId == selectedCartItem.variationId );
    if(index>=0){
      // this curr item is already exist into the list
      cartItems[index].quantity=selectedCartItem.quantity;

    }else{
      // item does not exist to the cartItems list
      // so, add the item into the list
      cartItems.add(selectedCartItem);
    }

    //Update cart
    updateCart();
    //show success message
    USnackBarHelpers.customToast(message: 'Your product has been added to the cart');

  ///------------------------[END]----------------------
  }

  /// method for increment or decrement cart quantity by clicking + or - icon
  void addOneToCart(CartItemModel item){
     int index= cartItems.indexWhere((cartItem)=> cartItem.productId== item.productId && cartItem.variationId== item.variationId);

     // if the item is available into the cart
    if(index>=0){
      cartItems[index].quantity++;
    }else{
      //if not available into the cart
      // then at first add the item to the cart
      //item.quantity++;
      cartItems.add(item);
    }

    // then call update cart method
    updateCart();

  }
  void removeOneFromCart(CartItemModel item){
    int index= cartItems.indexWhere((cartItem)=> cartItem.productId== item.productId && cartItem.variationId== item.variationId);

    // if the item is available into the cart
    if(index>=0){
      if(cartItems[index].quantity>1){
        cartItems[index].quantity--;
      }else{
        cartItems[index].quantity==1 ? removeFromCartDialog(index): cartItems.removeAt(index);
      }

    }

    // then call update cart method
    updateCart();

  }
  /// method for remove item from cart if quantity will be 0 after performing removeOnFromCart.
  void removeFromCartDialog(int index){
   Get.defaultDialog(
     title: "Remove Product",
     middleText: 'Are you sure? you want to remove this product?',
     onConfirm:(){
     cartItems.removeAt(index);
     updateCart();
     USnackBarHelpers.customToast(message: "Product has been removed from the cart");
     Get.back();

     },
     onCancel: (){},

   );
  }

  ///[ Get total quantity of same specific product]-------------------
  /// method for getting product total quantity in cart whose product id is same
  int getProductQuantityInCart(String productId){
    int  itemQuantity= cartItems.where((cartItem)=>cartItem.productId==productId).fold(
        0, (previousValue,cartItem)=> previousValue + cartItem.quantity,
    );

    return itemQuantity;
  }

  ///[ Get variation's quantity of the specific product]-----------
  /// method for getting  first variation_item's quantity from the cart
  int getVariationQuantityInCart(String productId, String variationId){
    CartItemModel firstVariation= cartItems.firstWhere((cartItem)=> cartItem.productId== productId
        && cartItem.variationId==variationId,
        orElse: ()=> CartItemModel.empty() );
    return firstVariation.quantity;
  }

  /// implement updateCart method
  void updateCart(){
    saveCartItems();
    updateCartTotals();
    cartItems.refresh();
  }
  /// Clear the cart
  void clearCart(){
    productQuantityInCart.value=0;
    cartItems.clear();
    updateCart();
  }

  /// implement save cart item method
  // for saving cart items in local storage
   void saveCartItems(){
     // convert model to json(Map<string, dynamic>) for storing in the local storage
     List<Map<String,dynamic>> cartItemList= cartItems.map((item)=> item.toJson()).toList();
     // save cart item into local storage
     _storage.write(UKeys.cartItemsKey, cartItemList);
   }


  /// implement updateCartTotals method
  // update totalCartPrice
  void updateCartTotals(){
    double calculateTotalPrice=0.0;
    int calculateNoOfItems=0;
    // iterate item list
    for(final item in cartItems){
      calculateTotalPrice+=(item.price * item.quantity).toDouble();
      calculateNoOfItems+=item.quantity;

    }
    totalCartPrice.value=calculateTotalPrice;
    noOfCartItems.value=calculateNoOfItems;

  }


  /// [Initialize already added items count in the cart]
  void updateAlreadyAddedProductCount(ProductModel product){
    // manage for single and variable product
    if(product.productType==ProductType.single.toString()){
      productQuantityInCart.value=getProductQuantityInCart(product.id);
    }else{
      String variationId=variationController.selectedVariation.value.id;
      if(variationId.isNotEmpty){
        productQuantityInCart.value=getVariationQuantityInCart(product.id, variationId);
      }else{
        productQuantityInCart.value=0;
      }
    }
  }

  /// method for converting product model to cart model
  CartItemModel convertCartItem(ProductModel product, int quantity){
    // for single product execute the if block
    if(product.productType==ProductType.single.toString()){
      // reset variation in case of single  product type
      variationController.resetSelectedAttributes();
    }

    // check variation for product
   ProductVariationModel variation =variationController.selectedVariation.value;
    bool isVariant=variation.id.isNotEmpty;
    // pick image for variation product / main product
    String image =isVariant ? variation.image: product.thumbnail;
    double price=isVariant ? variation.salePrice>0.0 ? variation.salePrice: variation.price : product.salePrice>0.0 ? product.salePrice: product.price;
    
    CartItemModel cartItem=CartItemModel(
        productId: product.id,
        quantity: quantity,
        title: product.title,
        brandName: product.brand !=null ? product.brand!.name: '',
        image: image,
        price: price,
        selectedVariation: isVariant? variation.attributeValues :null,
        variationId: variation.id,
    );

    return cartItem;

  }

  
  /// --------------------------[END]-----------------------
}