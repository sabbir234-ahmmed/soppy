import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart' as dio;
import 'package:e_commerce/data/services/cloudinary_services.dart';
import 'package:e_commerce/features/shopping/models/brand_category_model.dart';
import 'package:e_commerce/features/shopping/models/brands_model.dart';
import 'package:e_commerce/utils/constants/keys.dart';
import 'package:e_commerce/utils/exceptions/firebase_exceptions.dart';
import 'package:e_commerce/utils/exceptions/format_exceptions.dart';
import 'package:e_commerce/utils/exceptions/platform_exceptions.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BrandRepository extends GetxController{
  static BrandRepository get instance => Get.find();


  ///variables
  final _db=FirebaseFirestore.instance;
  final _cloudinaryServices = Get.put(CloudinaryServices());
  final _dio= dio.Dio();

  RxList<BrandModel> brands= <BrandModel> [].obs;

  ///[upload brands]---------------
  Future<void> uploadBrands(List<BrandModel>brands) async{
    
    try{

      /// at first upload brands on cloudinary
      for(BrandModel brand in brands){
        /// asset to file
        File brandImage= await UHelperFunction.assetToFile(brand.image);
        // upload
        dio.Response response= await _cloudinaryServices.uploadImage(brandImage, UKeys.brandsFolder);

        // check successfully uploaded or not?
        if(response.statusCode==200){
          // ok , then update brand url from asset to cloudinary url
          brand.image= response.data['url'];

          /// upload on fire store
          await _db.collection(UKeys.brandsCollection).doc(brand.id).set(brand.toJson());

        }else{
          print("---------Brand Upload Failed----------------");
        }

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


  ///[Fetch brands]----------------
  Future<List<BrandModel>> fetchBrand() async{
    try{

      /// fetch list of doc from fire store collection
      final query= await _db.collection(UKeys.brandsCollection).get();

      if(query.docs.isNotEmpty){
        /// iterate docs one by one and convert them into model
        List<BrandModel> brands=query.docs.map((document)=> BrandModel.fromSnapshot(document)).toList();

        return brands;
      }

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

  ///[Fetch brands]----------------
  //function to get category's brand
  Future<List<BrandModel>> fetchBrandForCategory(String categoryId ) async{
    try{
      // query to get all document wher category ids matches with the provided category ids form brand category collection
      final brandCategoryQuery= await _db.collection(UKeys.brandCategoryCollection).where('categoryId', isEqualTo: categoryId).get();

      // convert brandCategories  json to model
      List<BrandCategoryModel> brandCategories=brandCategoryQuery.docs.map((document)=>BrandCategoryModel.fromSnapshot(document)).toList();

      // List these brandIds
      List<String> brandIds=brandCategories.map((brandCategory)=> brandCategory.brandId).toList();

      //get brand according to brand ids
      final brandsQuery= await _db.collection(UKeys.brandsCollection).where(FieldPath.documentId, whereIn: brandIds).limit(2).get();
      // convert snapshot to model
      final List<BrandModel> brands= brandsQuery.docs.map((document)=> BrandModel.fromSnapshot(document)).toList();

      return brands;

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