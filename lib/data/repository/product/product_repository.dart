import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart' as dio;
import 'package:e_commerce/data/services/cloudinary_services.dart';
import 'package:e_commerce/features/shopping/models/product_model.dart';
import 'package:e_commerce/features/shopping/models/product_variation_model.dart';
import 'package:e_commerce/utils/constants/keys.dart';
import 'package:e_commerce/utils/exceptions/firebase_exceptions.dart';
import 'package:e_commerce/utils/exceptions/format_exceptions.dart';
import 'package:e_commerce/utils/exceptions/platform_exceptions.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:e_commerce/utils/popups/snackbar_helpers.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductRepository extends GetxController{
  static ProductRepository get instance => Get.find();

  /// variables
  final _cloudinaryServices= Get.put(CloudinaryServices());
  final _db =FirebaseFirestore.instance;


  /// [ upload Product]
  Future<void> uploadProducts(List<ProductModel> products) async{
    try{
      for(ProductModel product in products){
        /// convert thumbnail asset path to file
        File thumbnailFile= await UHelperFunction.assetToFile(product.thumbnail);
        /// upload Thumbnail on cloudinary
        dio.Response response= await _cloudinaryServices.uploadImage(thumbnailFile, UKeys.productsFolder);

        if(response.statusCode==200){
          product.thumbnail=response.data['url'];
        }else{
          print("-----------------Cloudinary Response is Not Okay-----------------");
        }

        /// handle images (list of image)
        if(product.images !=null && product.images!.isNotEmpty){
          List<String> imageUrls=[];

          for(String image in product.images!){
            /// asset to file
            File imageFile= await UHelperFunction.assetToFile(image);
            /// upload on cloudinary
            dio.Response response= await _cloudinaryServices.uploadImage(imageFile, UKeys.productsFolder);
            if(response.statusCode== 200){
              image=response.data['url'];
              imageUrls.add(image);
            }
          }

          /// update product variation images (replace asset path with cloudinary url)
          ///iterate variation
          if(product.productVariations!=null){
            for(ProductVariationModel variation in product.productVariations!){
              // query for get index where product.image == variation.image
              int index= product.images!.indexWhere((image)=> image==variation.image);
              //provide the specific  imageUrl to the variation image
              if (index != -1 && index < imageUrls.length) {
                variation.image = imageUrls[index];
              }
            }
          }

          /// assign  urls
          product.images!.clear();
          product.images!.assignAll(imageUrls);

        }

        /// now store product on fire store
       await _db.collection(UKeys.productsCollection).doc(product.id).set(product.toJson());

        print("------------------Product ${product.id} Uploaded Successfully-------------------------------");


      }

    }on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw("Something went wrong. Please try Again $e ");
    }
  }

  /// fetch featured products
  Future< List<ProductModel> > fetchFeaturedProducts() async{
    try{
      /// apply query for getting featured products
      final query=await _db.collection(UKeys.productsCollection).where('isFeatured',isEqualTo: true).limit(4).get();
      /// have doc or not??
      if(query.docs.isNotEmpty){
        List<ProductModel> product= query.docs.map((document)=> ProductModel.fromSnapshot(document)).toList();
        return product;
      }

      return [];

    }on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw("Something went wrong. Please try Again $e ");
    }
  }


  /// fetch all featured products
  Future< List<ProductModel> > fetchAllFeaturedProducts() async{
    try{
      /// apply query for getting featured products
      final query=await _db.collection(UKeys.productsCollection).where('isFeatured',isEqualTo: true).get();
      /// have doc or not??
      if(query.docs.isNotEmpty){
        List<ProductModel> product= query.docs.map((document)=> ProductModel.fromSnapshot(document)).toList();
        return product;
      }

      return [];

    }on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw("Something went wrong. Please try Again $e ");
    }
  }


  /// fetch products by query
  Future< List<ProductModel> > fetchProductByQuery(Query query) async{
    try{
      ///  getting  products according to query
      final querySnapshot=await  query.get();
      /// have doc or not??
      if(querySnapshot.docs.isNotEmpty){
        List<ProductModel> product= querySnapshot.docs.map((document)=> ProductModel.fromQuerySnapshot(document)).toList();
        return product;
      }

      return [];

    }on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw("Something went wrong. Please try Again $e ");
    }
  }


  /// get  products for brand
  Future<List<ProductModel>> getProductsForBrand( {required String brandId, int limit= -1 }) async{
    try{
      final query= limit==-1 ? await _db.collection(UKeys.productsCollection).where('brand.id',isEqualTo: brandId).get():
      await _db.collection(UKeys.productsCollection).where('brand.id',isEqualTo: brandId).limit(limit).get();

      if(query.docs.isNotEmpty){
        List<ProductModel> brandProducts= query.docs.map((document)=> ProductModel.fromSnapshot(document) ).toList();
        return brandProducts;
      }
      return [];
    }on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw("Something went wrong. Please try Again $e ");
    }




  }


  /// get  products of a specific category
  Future<List<ProductModel>> getProductsForCategory( {required String categoryId, int limit= 4 }) async{
    try{
      final productCategoryQuery= limit==-1 ? await _db.collection(UKeys.productCategoryCollection).where('categoryId',isEqualTo: categoryId).get():
      await _db.collection(UKeys.productCategoryCollection).where('categoryId',isEqualTo: categoryId).limit(limit).get();

       List<String> productIds=productCategoryQuery.docs.map((document)=>document['productId'] as String ).toList();

       // product query
       final productQuery=  await _db.collection(UKeys.productsCollection).where(FieldPath.documentId,whereIn: productIds).get();

       // convert productQuery to model
       List<ProductModel> products=  productQuery.docs.map((doc)=>ProductModel.fromSnapshot(doc)).toList();
       return products;

    }on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw("Something went wrong. Please try Again $e ");
    }




  }

  /// function to fetch favourite product from fire store
  Future< List<ProductModel> > fetchFavouriteProducts(List<String> productIds) async{
    try{
      
      /// apply query for getting favourite products
      final query=await _db.collection(UKeys.productsCollection).where(FieldPath.documentId,whereIn: productIds).get();
      /// have doc or not??
      if(query.docs.isNotEmpty){
        List<ProductModel> products= query.docs.map((document)=> ProductModel.fromSnapshot(document)).toList();
        return products;
      }

      return [];

    }on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw("Something went wrong. Please try Again $e ");
    }
  }


}