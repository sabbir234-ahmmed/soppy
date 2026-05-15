import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:e_commerce/data/repository/authentication_repository.dart';
import 'package:e_commerce/data/services/cloudinary_services.dart';
import 'package:e_commerce/features/authentication/models/user_model.dart';
import 'package:e_commerce/utils/constants/apis.dart';
import 'package:e_commerce/utils/constants/keys.dart';
import 'package:e_commerce/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:e_commerce/utils/exceptions/firebase_exceptions.dart';
import 'package:e_commerce/utils/exceptions/format_exceptions.dart';
import 'package:e_commerce/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  ///variables
  final _db = FirebaseFirestore.instance;
  final _cloudinaryServices=Get.put(CloudinaryServices());

   /// [create]------------------operation
  ///Function to store user data on firestore
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection(UKeys.userCollection).doc(user.id).set(
          user.toJson());
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try Again";
    }
  }

  /// [Read]------------ operation
  /// for fetching data from firebase ans convert it as a model and return
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot =await _db.collection(UKeys.userCollection).doc(AuthenticationRepository.instance.currentUser!.uid).get();
      if(documentSnapshot.exists){
        // create model of this user's data
        UserModel user= UserModel.fromSnapshot(documentSnapshot);
        return user;
      }

      // if user not exist then return empty model
      return UserModel.empty();



    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try Again";
    }
  }

  /// [update]------------------single field
  ///Function to update user's single field data on firestore
  Future<void> updateSingleField(Map<String, dynamic>map) async {
    try {
      await _db.collection(UKeys.userCollection).doc(AuthenticationRepository.instance.currentUser!.uid).update(map);
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try Again";
    }
  }


  /// [Delete]------------------
  ///Function to delete user's Record
  Future<void>  removeUserRecord(String userId) async {
    try {
      await _db.collection(UKeys.userCollection).doc(userId).delete();
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try Again";
    }
  }


  ///[UploadImage]------------------
  /// method for upload image on cloudinary
  Future<dio.Response> uploadImage(File image) async {
    try{
      dio.Response response= await _cloudinaryServices.uploadImage(image, UKeys.profileFolder);

      return response;

    }catch (e){
      throw "Failed to upload profile picture. Please try again";
    }
  }


  ///[DeleteImage]------------------
  /// method for delete user current profile picture
  Future<dio.Response> deleteProfilePicture(String publicId) async {
    try{
      dio.Response response= await _cloudinaryServices.deleteImage(publicId);
      return response;

    }catch (e){
      throw "Something went wrong. Please try again";
    }
  }



}