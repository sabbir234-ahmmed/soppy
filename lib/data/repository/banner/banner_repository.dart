import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart' as dio;
import 'package:e_commerce/data/services/cloudinary_services.dart';
import 'package:e_commerce/features/shopping/models/banners_model.dart';
import 'package:e_commerce/utils/constants/keys.dart';
import 'package:e_commerce/utils/exceptions/firebase_exceptions.dart';
import 'package:e_commerce/utils/exceptions/format_exceptions.dart';
import 'package:e_commerce/utils/exceptions/platform_exceptions.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BannerRepository extends GetxController{
  static BannerRepository get instance => Get.find();

  //variables
  final _db= FirebaseFirestore.instance;
  final _cloudinaryServices= Get.put(CloudinaryServices());

  ///[UploadBanners]---------------
  // function for upload banners on fire store
  Future<void> uploadBanners(List<BannerModel> banners) async{
    try{
      for(BannerModel banner in banners){

        ///convert  Asset path to file
        File image= await UHelperFunction.assetToFile(banner.imageUrl);
        /// upload single banner on cloudinary
        final dio.Response response=await _cloudinaryServices.uploadImage(image, UKeys.bannersFolder);
        //check response
        if(response.statusCode==200){
         banner.imageUrl=response.data['url'];
        }


        ///upload single doc(banner) on fire base fire store
        await  _db.collection(UKeys.bannersCollection).doc().set(banner.toJson());

        print("Banner Uploaded: ${banner.targetScreen}");

      }

    }on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try Again";
    }
  }

  /// [FetchBanner]---------------
  Future<List<BannerModel>> fetchActiveBanner() async{
    try{
       // get collection
       final query= await _db.collection(UKeys.bannersCollection).where('active', isEqualTo: true).get();

       // collection has document or not??
       if(query.docs.isNotEmpty){
         // has data
         List<BannerModel> banners=  query.docs.map((document)=> BannerModel.fromDocument(document) ).toList();
        // print("------------Inside and return banner-----------------------");
         return banners;
       }

      // print("------Return Empty banners---------");
       return [];

    }on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try Again";
    }
  }
}