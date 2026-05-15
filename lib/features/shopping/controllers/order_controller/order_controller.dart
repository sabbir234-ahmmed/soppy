import 'package:e_commerce/common/screens/success_screen.dart';
import 'package:e_commerce/data/repository/authentication_repository.dart';
import 'package:e_commerce/data/repository/order/order_repository.dart';
import 'package:e_commerce/features/personalization/controllers/address_controller.dart';
import 'package:e_commerce/features/shopping/controllers/card/cart_controller.dart';
import 'package:e_commerce/features/shopping/controllers/checkout/checkout_controller.dart';
import 'package:e_commerce/features/shopping/models/order_model.dart';
import 'package:e_commerce/navigation_menu.dart';
import 'package:e_commerce/utils/constants/enums.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:e_commerce/utils/popups/full_screen_loader.dart';
import 'package:e_commerce/utils/popups/snackbar_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OrderController extends GetxController{
  static OrderController get instance => Get.find();

  //variables
  final CartController cartController=CartController.instance;
  final CheckOutController checkOutController= Get.put(CheckOutController());
  final AddressController addressController= Get.put(AddressController());
  final OrderRepository _orderRepository= Get.put(OrderRepository());

  /// process order method
  Future<void> processOrder(double totalAmount) async{
    try{
       /// start loading
      UFullScreenLoader.openLoadingDialog("Processing on Your order...");

      /// check user existence
      String userId=AuthenticationRepository.instance.currentUser!.uid;

      /// check user empty or not
      if(userId.isEmpty){
        return ;
      }

      // if user exist then create a order model
      OrderModel order= OrderModel(
          id: UniqueKey().toString(),
          status: OrderStatus.pending,
          items: cartController.cartItems.toList(),
          totalAmount: totalAmount,
          orderDate: DateTime.now(),
           userId: userId,
           paymentMethod:checkOutController.selectedPaymentMethod.value.name,
           address: addressController.selectedAddress.value,
          deliveryDate: DateTime.now(),
      );

      /// call postOrder method for posting order
       await _orderRepository.postOrder(order);

       // clear the cart
      cartController.clearCart();

        // show success screen
      Get.to(
        SuccessScreen(
          title: "PayMent Success!",
          subtitle: "Your items will be Shipped Soon" ,
          image: UImages.successfulPaymentIcon,
          onTap: (){
            Get.offAll(NavigationMenu());
          },
        ),
      );

    }catch (e){
       throw USnackBarHelpers.errorSnackBar(title: "Failed",message: e.toString());
    }
  }

  /// get orders list
  Future<List<OrderModel>> getOrders() async{
    try{
     final List<OrderModel> orders= await _orderRepository.fetchOrders();
     return orders;

    }catch (e){
      throw USnackBarHelpers.errorSnackBar(title: "Failed", message: e.toString());

    }
  }
}