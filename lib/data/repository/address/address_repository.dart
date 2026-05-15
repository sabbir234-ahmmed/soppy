import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/data/repository/authentication_repository.dart';
import 'package:e_commerce/features/personalization/models/address_model.dart';
import 'package:e_commerce/utils/constants/keys.dart';
import 'package:e_commerce/utils/exceptions/firebase_exceptions.dart';
import 'package:e_commerce/utils/exceptions/format_exceptions.dart';
import 'package:e_commerce/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddressRepository extends GetxController{
  static AddressRepository get instance => Get.find();

  /// variables
  final _db =FirebaseFirestore.instance;

  /// [UPLOAD NEW ADDRESS]---------------------and get id
  Future<String> addAddress(AddressModel address) async{
    try{
      final userId=AuthenticationRepository.instance.currentUser!.uid;
     final currentAddress= await _db.collection(UKeys.userCollection).doc(userId).collection(UKeys.addressCollection).add(address.toJson());
     /// update currentAddress id field
      await _db.collection(UKeys.userCollection).doc(userId).collection(UKeys.addressCollection).doc(currentAddress.id).update(
          {'id':currentAddress.id});

     return currentAddress.id;

    }on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong while saving Address Information. Please try again";
    }
  }

  /// [fetch ADDRESS]---------------------
  Future<List<AddressModel>> fetchAddress( ) async{
    try{
      final userId=AuthenticationRepository.instance.currentUser!.uid;

      if(userId.isNotEmpty){
        final addressQuery= await _db.collection(UKeys.userCollection).doc(userId).collection(UKeys.addressCollection).get();

        if(addressQuery.docs.isNotEmpty){
          List<AddressModel> addresses= addressQuery.docs.map((document)=> AddressModel.fromDocumentSnapshot(document)).toList();
          return addresses;

        }

      }

      return [];
    }on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong while fetching Address Information. Please try again";
    }
  }

  /// [UPDATE SELECTED FIELD]--------------------------------
  Future<void> updateSelectedField(String addressId, bool selected) async{
   try{
     final userId=AuthenticationRepository.instance.currentUser!.uid;
     await _db.collection(UKeys.userCollection).doc(userId).collection(UKeys.addressCollection).doc(addressId).update({'selectedAddress':selected});
     print("--Under repo Update selected field------Current UserId: $userId, ------------User AddressId: $addressId--------------$selected");


   }catch (e){
      throw "------------------Unable to Update selected Field: ${e.toString()}---------------------------";
   }
  }
}