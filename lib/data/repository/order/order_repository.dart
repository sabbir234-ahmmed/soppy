import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/data/repository/authentication_repository.dart';
import 'package:e_commerce/features/shopping/models/order_model.dart';
import 'package:e_commerce/utils/constants/keys.dart';
import 'package:e_commerce/utils/exceptions/firebase_exceptions.dart';
import 'package:e_commerce/utils/exceptions/format_exceptions.dart';
import 'package:e_commerce/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OrderRepository extends GetxController{
  static OrderRepository get instance => Get.find();

  /// variables
  final _db=FirebaseFirestore.instance;

  /// method for post order
  Future<void> postOrder(OrderModel order) async{
    try{
     _db.collection(UKeys.userCollection).doc(order.userId).collection(UKeys.orderCollection).add(order.toJson());

    }on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong while saving order Information. Please try again";
    }
  }


  ///[ Method for fetch orders]-------------------
  Future<List<OrderModel>> fetchOrders() async{
    try{
      final userId=AuthenticationRepository.instance.currentUser!.uid;
     final QuerySnapshot querySnapshot= await _db.collection(UKeys.userCollection).doc(userId).collection(UKeys.orderCollection).get();

     if(querySnapshot.docs.isNotEmpty){
       final List<OrderModel> orders=querySnapshot.docs.map((documentSnapshot){
         return OrderModel.fromSnapshot(documentSnapshot);
       }).toList();

       return orders;
     }

     return [];

    }on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong while saving order Information. Please try again";
    }
  }
}