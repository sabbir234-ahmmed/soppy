import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart' as dio;
import 'package:e_commerce/data/services/cloudinary_services.dart';
import 'package:e_commerce/features/shopping/models/brand_category_model.dart';
import 'package:e_commerce/features/shopping/models/category_model.dart';
import 'package:e_commerce/features/shopping/models/product_category_model.dart';
import 'package:e_commerce/utils/constants/keys.dart';
import 'package:e_commerce/utils/exceptions/firebase_exceptions.dart';
import 'package:e_commerce/utils/exceptions/format_exceptions.dart';
import 'package:e_commerce/utils/exceptions/platform_exceptions.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CategoryRepository extends GetxController{
  static CategoryRepository get instance => Get.find();

  /// variables
  final _db=FirebaseFirestore.instance;
  final _cloudinaryServices= Get.put(CloudinaryServices());

  /// [uploadBrandCategoryRelation]---------
  /// store on fire store
  Future<void> uploadBrandCategory(List<BrandCategoryModel> brandCategories) async{
    try{
      for(BrandCategoryModel brandCategory in brandCategories){
        await _db.collection(UKeys.brandCategoryCollection).doc().set(brandCategory.toJson());
        print("-----------------Upload BrandCategory ${brandCategory.brandId}--------------------");
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

  /// [uploadProductCategoryRelation]---------
  /// store on fire store
  Future<void> uploadProductCategory(List<ProductCategoryModel> productCategories) async{
    try{
      for(ProductCategoryModel productCategory in productCategories){
        await _db.collection(UKeys.productCategoryCollection).doc().set(productCategory.toJson());
        print("-----------------Upload productCategory ${productCategory.productId}--------------------");
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


  /// [UploadCategories]-------
  // function to upload list of categories
 Future<void> uploadCategories(List<CategoryModel> categories) async{
     try{
        for( final category in categories) {
          // convert asset to file
          File image= await UHelperFunction.assetToFile(category.image);  // asset image path

          // upload on cloudinary
          dio.Response response= await _cloudinaryServices.uploadImage(image, UKeys.categoryFolder);
          if(response.statusCode==200){
            category.image=response.data['url'];
          }

          // upload on fire store
         await _db.collection(UKeys.categoriesCollection).doc(category.id).set(category.toJson());

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


  /// [FetchCategories]--------
  // Function to fetch list of categories
  Future<List<CategoryModel>> getAllCategories() async{
    try{
      /// get collection
      final query= await _db.collection(UKeys.categoriesCollection).get();
      if(query.docs.isNotEmpty){
         // convert document to Model
         List<CategoryModel> categories= query.docs.map((document)=> CategoryModel.fromSnapshot(document)).toList();
         return categories;
      }

      // if empty
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


  /// [FetchSUBCategories]--------
  // Function to fetch list of sub  categories
  Future<List<CategoryModel>> getSubCategories(String categoryId) async{
    try{
      /// get collection
      final query= await _db.collection(UKeys.categoriesCollection).where('parentId',isEqualTo: categoryId).get();
      if(query.docs.isNotEmpty){
        // convert document to Model
        List<CategoryModel> subCategories= query.docs.map((document)=> CategoryModel.fromSnapshot(document)).toList();
        return subCategories;
      }

      // if empty
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