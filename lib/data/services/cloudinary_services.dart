
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart' as dio;
import 'package:e_commerce/utils/constants/apis.dart';
import 'package:e_commerce/utils/constants/keys.dart';
import 'package:get/get.dart';

class CloudinaryServices extends GetxController{
  static CloudinaryServices get instance=> Get.find();

  /// variables
  final _dio=dio.Dio();

  /// [UploadImage]-----------------
  /// method for upload image on cloudinary
  Future<dio.Response> uploadImage(File image, String folderName) async {
    try{
      // get api
      String api=UApiUrls.uploadApi(UKeys.cloudName);
      // prepare data for upload
      dio.FormData formData= dio.FormData.fromMap({
        'upload_preset': UKeys.uploadPreset ,
        'folder': folderName,
        'file': await dio.MultipartFile.fromFile(image.path, filename: image.path.split('/').last),
      });
      // hit the api or upload data
      dio.Response response= await _dio.post(api,data: formData );

      return response;

    }catch (e){
      throw "Failed to upload profile picture. Please try again";
    }
  }

  /// [DeleteImage]-------------------
  /// method for delete Image on Cloudinary
  Future<dio.Response> deleteImage(String publicId) async {
    try{
      // get delete api
      String api=UApiUrls.deleteApi(UKeys.cloudName);
      // create timestamp
      int timestamp= (DateTime.now().millisecondsSinceEpoch/1000).round();
      // create signature
      String signatureBass='public_id=$publicId&timestamp=$timestamp${UKeys.apiSecret}';
      // encode through crypto
      String signature=sha1.convert(utf8.encode(signatureBass)).toString();
      // prepare data
      dio.FormData formData= dio.FormData.fromMap({
        'public_id': publicId ,
        'api_key': UKeys.apiKey,
        'timestamp': timestamp,
        'signature': signature,
      });

      // hit the api for delete data
      dio.Response response= await _dio.post(api,data: formData );

      return response;

    }catch (e){
      throw "Something went wrong. Please try again";
    }
  }


}