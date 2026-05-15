import 'package:e_commerce/data/repository/order/order_repository.dart';
import 'package:e_commerce/features/personalization/controllers/address_controller.dart';
import 'package:e_commerce/features/shopping/controllers/card/cart_controller.dart';
import 'package:e_commerce/features/shopping/controllers/checkout/checkout_controller.dart';
import 'package:e_commerce/features/shopping/controllers/order_controller/order_controller.dart';
import 'package:e_commerce/features/shopping/controllers/product/variation_controller.dart';
import 'package:e_commerce/utils/helpers/network_manager.dart';
import 'package:get/get.dart';

class UBindings extends Bindings{
  @override
  void dependencies(){

    Get.put(NetworkManager());


    Get.put(VariationController());

    Get.lazyPut(()=>CheckOutController());

    Get.lazyPut(()=>AddressController());

    Get.lazyPut(()=>OrderController());

    Get.lazyPut(()=>CartController());

  }
}